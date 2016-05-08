# GitHubDownloader

Download all the repositories from a GitHub useraccount

# Installation

sudo apt-get install libcurl4-openssl-dev
sudo cpan JSON WWW:curl

# Prerequisite
1. Setup rsa ssh keys in .ssh appropriately (so that you have ssh access to repositories)

# Usage

* Call the perl script with the parameter
```perl
 perl getRepos.pl [--type {users|orgs}]  --name <username>
```

* Example:
```perl
perl getRepos.pl -n <username>
perl getRepos.pl -n <username>
```

#TO Do

Support to pull changes automatically.
