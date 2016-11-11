# Bloc [![Build status](https://travis-ci.org/pharo-graphics/Bloc.svg?branch=master)](https://travis-ci.org/pharo-graphics/Bloc) [![Build status](https://ci.appveyor.com/api/projects/status/x6vjn4ccy37xasrd?svg=true)](https://ci.appveyor.com/project/GlennCavarle/bloc) [![Coverage Status](https://coveralls.io/repos/github/pharo-graphics/Bloc/badge.svg?branch=master)](https://coveralls.io/github/pharo-graphics/Bloc?branch=master)

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

Main maintainers : [Glenn Cavarlé](https://github.com/GlennCavarle) & [Aliaksei Syrel](https://github.com/syrel)

  - Jenkins Job on [pharo-contribution](https://ci.inria.fr/pharo-contribution/job/Bloc/)
  - "In progress" Documentation \[ [html](https://ci.inria.fr/pharo-contribution/job/PharoBookWorkInProgress/lastSuccessfulBuild/artifact/book-result/Bloc/Bloc.html) | [pdf](https://ci.inria.fr/pharo-contribution/job/PharoBookWorkInProgress/lastSuccessfulBuild/artifact/book-result/Bloc/Bloc.pdf) \] (not yet up-to-date)



# Installation

## Bloc Zeroconf Script

These scripts download the latest Pharo 60 Image + the stable Pharo VM for 60 and installs the latest version of Bloc.

(All-in-one "user" versions)
`wget -O- https://goo.gl/YYHH5a | bash` 

(All-in-one "developer" versions)
`wget -O- https://goo.gl/HQAPI5 | bash` 


## Last version based on [Athens](http://smalltalkhub.com/#!/~Pharo/Athens)

Version v0.10 is the last version with Athens support "out of the box".

This means that libMoz2D binary is not needed for this version.

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc:v0.10/src';
    load
```


## All-in-one "developer" versions 
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
## All-in-one "user" versions 
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


## All-in-one code-only versions 
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



