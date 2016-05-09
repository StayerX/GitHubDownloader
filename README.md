# GitHub Downloader

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

# Example:
```perl
perl getRepos.pl -n StayerX # Download the repositories for a user
perl getRepos.pl -t orgs -n project-renard # and for an organisation
```
* Note: if you do `CTRL + c` it should skip a repository

## Contributing

1. Fork it [https://github.com/StayerX/GitHubDownloader/fork](https://github.com/StayerX/GitHubDownloader/fork )
2. Create your feature branch (`git checkout -b <my-new-feature>`)
3. Commit your changes (`git commit -am 'Add some feature'`)
3. Push your changes (`git push`)

# TO Do

Support to pull changes automatically.
