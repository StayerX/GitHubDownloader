#! /usr/bin/perl

# use module
use strict;
use warnings;
use WWW::Curl::Easy;

# use module
use lib qw(..);
use JSON qw( );

require Encode;

# Following is the implementation of simple Class.
package GitHubDownloader;
sub new
{
	my $proto = shift;
	my $class = ref($proto) || $proto;
	print "GitHubDownloader::new called\n";
	my $self = {
		 _type => shift,            # The organisation type
		 _name => shift,            # The organisation name
		 _class => $class,
		 response_body => ''
	};
	# Print all the values just for clarification.
	print "Class:: $class\n";
	print "You are trying to download all repos from a GitHub structure: $self->{_type}\n";
	print "\twith the GitHub name: $self->{_name}\n";
	return bless $self, $class;   
}

sub prepare{
	my ($self) = @_;
	print $self->{_class} . "::prepare called!\n";
	my $curl = WWW::Curl::Easy->new;

	$curl->setopt(WWW::Curl::Easy::CURLOPT_HEADER,1);
	$curl->setopt(WWW::Curl::Easy::CURLOPT_URL, 'https://api.github.com/' . $self->{_type} . '/' . $self->{_name} . '/repos');
	$curl->setopt(WWW::Curl::Easy::CURLOPT_USERAGENT, "Dark Secret Ninja/1.0");
	
	#future work: https://api.github.com/users/StayerX/orgs

	my $response_bd;
	$curl->setopt(WWW::Curl::Easy::CURLOPT_WRITEDATA,\$response_bd);

	# Starts the actual request
	my $retcode = $curl->perform;

	# Looking at the results...
	if ($retcode == 0) {
		print("Transfer went ok\n");
		my $response_code = $curl->getinfo(WWW::Curl::Easy::CURLINFO_HTTP_CODE);
		# judge result and next action based on $response_code
		$self->{response_body} = $response_bd;
		# print("Received response: $self->{response_body}\n");
	} else {
		# Error code, type of error, error message
		print("An error happened: $retcode ".$curl->strerror($retcode)." ".$curl->errbuf."\n");
	}

	# A filehandle, reference to a scalar or reference to a typeglob can be used here.
}

sub downloadAll
{
	my $self = shift;
	print $self->{_class} . "::donloadAll called!\n";
	defined $self->{response_body} or die('Missing response from GitHub');

	my $tmp = $self->{response_body};
	my $utmp = Encode::decode( 'iso-8859-1', $tmp );
	my $start = index($utmp, "[");
	my $end = index($utmp, "]");
	my $data = substr($utmp, $start, $end);
	
	#print("Received response: $data\n");

	my $json = JSON->new;
	$data = $json->decode($data);
	

	for ( @{$data} ) {
		my $cmd = 'git clone ' .  $_->{ssh_url} . "\n";
		system($cmd);
	}
}

sub DESTROY
{
	my $self = shift;
	print $self->{_class} . "::DESTROY called\n";
}

# Here is the main program using above classes.
package main;
use strict;
use warnings;
use Getopt::Long qw(GetOptions);
 
my $type = 'users';
my $name = 'username';
GetOptions(
    'type|t=s' => \$type,
    'name|n=s' => \$name,
) or die "Usage: $0 --type users  --name <username>`\n";

$name ne 'username' or die "Usage: $0 --type users  --name <username>`\n";

print "Invoke GitHubDownloader method prepare\n";

my $myObject = GitHubDownloader->new($type, $name);
$myObject->prepare;

print "Invoke GitHubDownloader method downloadAll\n";
$myObject->downloadAll;

print "Fall off the end of the script...\n";
# Remaining destructors are called automatically here
