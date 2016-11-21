# Contributing to Bloc

The following is a set of guidelines for contributing to [Bloc](https://github.com/pharo-graphics/Bloc), which are hosted in the [Pharo Graphics Organization](https://github.com/pharo-graphics) on GitHub.

#### Table Of Contents
* [What should I know before I get started?](#what-should-i-know-before-i-get-started)
  * [*User* and *Developer* versions](#user-and-developer-versions)
  * [Design Decisions](#design-decisions)
* [How Can I Contribute?](#how-can-i-contribute)
  * [Reporting Bugs](#reporting-bugs-and-suggesting-enhancements)
  * [Submitting changes](#submitting-changes)

## What should I know before I get started?

### *User* and *Developer* versions

To load the sources in a Pharo image, you have the choice between the [User]() and [Developer]() versions. 

- The *User* version is **read-only**. This version is typically used for discovery and testing purposes but also as a Metacello dependency.  **You cannot contribute** using the *User* version but you can freely load it and use it as a dependency in your project, adding the following in your metacello configuration or baseline:

```smalltalk
 spec 
	 baseline: 'Bloc' 
	 with: [ spec 
		 loads: #core;
		 repository: 'github://pharo-graphics/Bloc/src:[master|v*]']
```

- The *Developer* version includes the installation of [Iceberg](https://github.com/npasserini/iceberg). As mentioned in [Iceberg prerequisites](https://github.com/npasserini/iceberg#prerequisites), you should ensure that you have  [registered an SSH key](https://help.github.com/articles/generating-an-ssh-key/) on Github before loading this version.   you might need to refer to the [Iceberg wiki](https://github.com/npasserini/iceberg/wiki) if you are not used to *Iceberg*. This version **automatically** installs *Iceberg*, you don't have to install it manually.
Being able to load this version does not necessarily mean that you are allowed to contribute directly on the master branch. Only members of the [Pharo Graphics Organization](https://github.com/orgs/pharo-graphics/people) are able to make direct contributions ([How Can I Contribute?](#how-can-i-contribute)).
  

### Design Decisions

When we make a significant decision, we will document it in [Issues](https://github.com/issues?q=is%3Aissue+user%3Apharo-graphics+sort%3Acomments-desc) or/and in [pharo-graphics/design-decisions repository](https://github.com/pharo-graphics/design-decisions) (soon). If you have a question around how we do things, check also to see if it is documented [there](https://github.com/pharo-graphics/Bloc/wiki). If it is *not* documented there, please open a new topic on [Issues](https://github.com/pharo-graphics/Bloc/issues) and ask your question.


## How Can I Contribute?

### Reporting bugs and suggesting enhancements

Before creating issues, please check [this list](https://github.com/issues?q=is%3Aissue+user%3Apharo-graphics+sort%3Acomments-desc) as you might find out that you don't need to create one. When you are creating a [new issue](https://github.com/pharo-graphics/Bloc/issues/new), please include as many details as possible to help maintainers reproduce the problem or understand your suggestion.


### Submitting changes

Like most projects, we propose a standard [GitHub Flow](https://guides.github.com/introduction/flow/index.html) for contributions:

1. Fork
2. Create a topic branch
3. Add commits
4. Create a Pull Request
5. Discuss and review your code
6. Merge

If you want to submit changes, please send a [GitHub Pull Request](https://github.com/pharo-graphics/Bloc/pull/new/master) with a clear list of what you've done (read more about [pull requests](https://help.github.com/categories/collaborating-with-issues-and-pull-requests/)). Please make sure all of your commits are atomic (one feature per commit) and always write a clear log message for your commits to help maintainers understand and review your submission.
