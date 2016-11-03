# Bloc

[![Build status](https://travis-ci.org/pharo-graphics/Bloc.svg?branch=master)](https://travis-ci.org/pharo-graphics/Bloc) [![Build status](https://ci.appveyor.com/api/projects/status/x6vjn4ccy37xasrd?svg=true)](https://ci.appveyor.com/project/GlennCavarle/bloc) [![Coverage Status](https://coveralls.io/repos/github/pharo-graphics/Bloc/badge.svg?branch=master)](https://coveralls.io/github/pharo-graphics/Bloc?branch=master)

## Bloc is a low-level UI framework for Pharo

Main maintainers : [Glenn Cavarlé](https://github.com/GlennCavarle) & [Aliaksei Syrel](https://github.com/syrel)


## Bloc Zeroconf Script

This script downloads the latest Pharo 60 Image + the stable Pharo VM for 60 and installs the latest version of Bloc.

`wget -O- https://goo.gl/YYHH5a | bash`

## Manual installation

Iceberg is mendatory to be able to commit on Bloc (for developers only).

```smalltalk
Metacello new
    baseline: 'Iceberg';
    repository: 'github://npasserini/iceberg';
    load.
```
Install Bloc in a Pharo 60 image by evaluating this script in a playground:

```smalltalk
Metacello new
    baseline: 'Bloc';
    repository: 'github://pharo-graphics/Bloc/src';
    load
```



```
