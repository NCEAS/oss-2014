
# Some random notes about learning git

If you plan to regularly use git to push/pull data from GitHub, I'd recommend installing hub: https://github.com/github/hub#git--hub--github

It makes like a lot simpler. 
Instead of:

```
git clone https://github.com/nceas/training/
```
you can do:

```
git clone nceas/training
```

Simply use the organization/account name and the repo name.

You can also easily open the URL by typing:

```
git browse
```

You should add an alias so that typing `git` actually executes `hub`. You do this by adding:

```
alias git=hub
```
in your bash profile. If a command does not exist in hub, it will default safely back to git.


More commands and things you can do with hub are described in detail here: https://github.com/github/hub#commands

