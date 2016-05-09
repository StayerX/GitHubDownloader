# GitHub-Downloader

Download all the repositories from a GitHub useraccount

# Installation
```sh
sudo apt-get install libcurl4-openssl-dev
sudo cpan JSON WWW:curl
```

# Prerequisite
* Setup `rsa` `ssh keys` in `.ssh` appropriately (so that you have ssh access to repositories)

# Usage

* Call the perl script with the parameter
```perl
 perl getRepos.pl [--type {users|orgs}]  --name <username>
```

* Example:
```perl
perl getRepos.pl -n StayerX # Download the repositories for a user
perl getRepos.pl -t orgs -n project-renard # and for an organisation
```
* Note: if you do `CTRL + c` it should skip a repository

# TO Do

Support to pull changes automatically.
