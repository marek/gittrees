gittrees
========
gittrees is a git template that allows you to
provide subtree meta data with your repository.
Define your subtrees in .gittrees and the hooks provided
with the template will configure your remotes
on a clone or checkout.


submodules vs subtrees
--------
Both allow you to import another
repository as a sub branch.

##### submodules #####
By running `git submodule add <url> <path>`, git stores the submodules
definitions in the `<project>/.gitmodules` file.
When you clone a project or checkout a branch, the submodule code is
not checked out by default. You need to explicitly pull in source
using the `git submodule update --init` command.

Every time you clone a project these submodules remain defined.

##### subtrees #####
On the other hand subtrees merge another repository's code directly
into your current project. Everytime you clone the code is there.
Although it is your responsiblity to add the remotes for the subtree.


This is an annoyance if a lot of people are working on the same project.
If a new person glances at the code base, how would you know where the source came from?


Solution
--------
git subtree helper templates. These templates have a script
that will read a .gittrees file from your project's root
and then setup the remotes for you.

The syntax of this .gittrees file is borrowed from:
`https://github.com/helmo/git/tree/subtree-updates`
A project that modifies the git subtree feature itself.


Installation
-------
Check out the source and set the default git template:
```
git clone git@github.com:marek/gittrees.git
git config --global init.templatedir /path/to/gittrees/template
```


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


Hooks and git Template
======
This repo is meant for showing off a script for subtrees,
but the base project template also allows an easy way of adding
multiple hooks for the same call.

Drop scripts into your:

<template dir>/defaults
<template dir>/local
<project dir>/hooks

where the script is named:

`<hook name>` or `<hook name>.<unique name>`
example

post-commit.foo

don't forget the execute permissions!

