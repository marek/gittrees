gittrees
========
gittrees is a git template that allows you to
provide subtree meta data with your repository.
Define your subtrees in .gittrees and the hooks provided
with the template will configure your remotes and subtrees
on a clone or checkout.


submodules vs subtrees
--------
Both at work and home, my git repositories use a
lot of submodules and subtrees. They are very similar
in that they both allow you to import another
repository as a sub branch.

##### submodules #####
git defines submodules in the `<project>/.gitmodules`
You need to explicitly pull in source using the `git submodule` command.
Every time you clone a project these submodules remain defined.

##### subtrees #####
On the other hand subtrees merge another repository's code directly
into your current project. Everytime you clone the code is there.
Although it is your responsiblity to add the remotes for the subtree
and also define their local branch.


This is an annoyance if a lot of people are working on the same project.
If a new person glances at the code base, how would you know you needed to
add a subtree?


solution
--------
git subtree helper templates




installation
=========
git clone git@github.com:marek/gittrees.git
git config --global init.templatedir /path/to/gittrees/template

In your project that uses subtrees create a file named `.gittrees`
in the root. An example of the contents is as shown:

```
[subtree "coollib"]
url = git@myserver.com/repos/coollib.git
path = src/coollib
branch = master

[subtree "test"]
url = file:///home/marek/workspace/samplesubtree
path = sample
branch = master
```

The syntax of an individual definition is:
```
[subtree "<remote name>"]
url = <remote url>
path = <local project path that is the subtree root>
branch = <remote subtree branch>
```


