# Installation

#### Table Of Contents
* [What should I know before I get started?](#what-should-i-know-before-i-get-started)
  * [*User* and *Developer* versions](#user-and-developer-versions)
  * [*#core* and *#development* groups](#core-and-development-groups)
* [How Can I Install?](#how-can-i-install)
  * [Bloc Zeroconf Scripts](#bloc-zeroconf-script)
  * [All-in-one "User" versions](#all-in-one-user-versions)
  * [All-in-one "Developer" versions](#all-in-one-developer-versions)
  * [Code-only versions](#code-only-versions)
  * [Last version based on Athens](last-version-based-on-athens) (no support)


## What should I know before I get started?


### *User* and *Developer* versions

To load the sources in a Pharo image, you have the choice between the [User](#all-in-one-user-versions),
the [Developer](#all-in-one-developer-versions) and the [code-only](#all-in-one-code-only-versions) versions.

The *User* and *Developer* versions are *all-in-one*: all required dependencies are also loaded during the installation.
This means that, for both versions, the [Moz2D](https://github.com/syrel/Moz2D) binary is **automatically** downloaded and installed in the VM directory. 

- The *User* version is  **all-in-one** and **read-only**. it is typically used for discovery and testing purposes but also as a Metacello dependency.
**You cannot contribute** using the *User* version but you can freely load it and use it as a dependency in your project, adding the following in your metacello configuration or baseline:

```smalltalk
 spec 
	 baseline: 'Bloc' 
	 with: [ spec 
		 loads: #core;
		 repository: 'github://pharo-graphics/Bloc/src:[master|v*]']
```

- The *Developer* version is  **all-in-one** and includes the **installation of [Iceberg](https://github.com/npasserini/iceberg)**.
As mentioned in [Iceberg prerequisites](https://github.com/npasserini/iceberg#prerequisites), 
you should ensure that you have  [registered an SSH key](https://help.github.com/articles/generating-an-ssh-key/) on Github before loading this version.
You might need to refer to the [Iceberg wiki](https://github.com/npasserini/iceberg/wiki) if you are not used to *Iceberg*. 
This version **automatically** installs *Iceberg*, you don't have to install it manually.

- The *Code-Only* version, as its name suggests, includes only sources: [Moz2D](https://github.com/syrel/Moz2D) binary and [Iceberg](https://github.com/npasserini/iceberg) **are not installed**.

### `#core` and `#development` groups

For each version, the `#core` and `#development` groups are provided. 
The difference between these two groups is that the `#developement` group includes also pachages related to *tests*, *dev tools* and *experiments*. 


## How Can I Install?

### Bloc Zeroconf Script

These scripts download the latest Pharo 60 Image + the stable Pharo VM for 60 and installs the latest version of Bloc.

(All-in-one "user" versions)
`wget -O- https://goo.gl/YYHH5a | bash` 

(All-in-one "developer" versions)
`wget -O- https://goo.gl/HQAPI5 | bash` 




### All-in-one "User" versions
[Bloc](https://github.com/pharo-graphics/Bloc) + [Sparta](https://github.com/syrel/Sparta) + [Moz2D](https://github.com/syrel/Moz2D)

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc/src';
    load:#core
```

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc/src';
    load:#development
```

### All-in-one "Developer" versions 
[Bloc](https://github.com/pharo-graphics/Bloc) + [Sparta](https://github.com/syrel/Sparta) + [Moz2D](https://github.com/syrel/Moz2D) + [Iceberg](https://github.com/npasserini/iceberg)

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc/src';
    load:#git:core
```

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc/src';
    load:#git:development
```

### Code-only versions 
[Bloc](https://github.com/pharo-graphics/Bloc) + [Sparta](https://github.com/syrel/Sparta)

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc/src';
    load:#file:core
```

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc/src';
    load:#file:development
```

### Last version based on [Athens](http://smalltalkhub.com/#!/~Pharo/Athens)

Version v0.10 is the last version with Athens support "out of the box".

This means that libMoz2D binary is not needed for this version.

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc:v0.10/src';
    load
```
