# Bloc

[Installation](#installation) | [Contributing](#contributing) |  [License](#license)

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg?style=flat-square)][license]
[![Travis](https://img.shields.io/travis/pharo-graphics/Bloc.svg?style=flat-square)][travis]
[![AppVeyor](https://img.shields.io/appveyor/ci/pharo-graphics/Bloc.svg?style=flat-square)][appveyor]
[![Coveralls](https://img.shields.io/coveralls/pharo-graphics/Bloc.svg?style=flat-square)][coveralls]
[![Jenkins](https://img.shields.io/jenkins/s/https/ci.inria.fr/pharo-contribution/job/Bloc.svg?style=flat-square)][jenkins]

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

Main maintainers : [Glenn Cavarlé](https://github.com/GlennCavarle) & [Aliaksei Syrel](https://github.com/syrel)

  - Jenkins Job on [pharo-contribution][jenkins]
  - "In progress" Documentation \[ [html][dochtml] | [pdf][docpdf] \] (not yet up-to-date)



## Installation


### Bloc Zeroconf Script

These scripts download the latest Pharo 60 Image + the stable Pharo VM for 60 and installs the latest version of Bloc.

(All-in-one "user" versions)
`wget -O- https://goo.gl/YYHH5a | bash` 

(All-in-one "developer" versions)
`wget -O- https://goo.gl/HQAPI5 | bash` 

**More detailed installation guide is described [here](INSTALL.md)**

## Ubuntu 64bit

In order to run Bloc on top of 32bit Pharo on 64bit machine you have to install 32bit compatibility packages:

    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install libstdc++6:i386 libx11-6:i386 libglu1-mesa:i386 libfontconfig1:i386 libssl1.0.0:i386
    sudo apt-get install libgtk2.0-0:i386 libgtk-3-0:i386

## Windows

Sparta/Moz2D graphics API requires Visual C++ Redistributable for Visual Studio 2015:<br>
https://www.microsoft.com/en-US/download/details.aspx?id=48145

## Contributing

Want to contribute on Bloc? Awesome!
We have [instructions to help you get started contributing code or documentation][contributing].

## License

Licensed under the [MIT license][license].


[travis]: https://travis-ci.org/pharo-graphics/Bloc
[license]: ./LICENSE
[contributing]: ./CONTRIBUTING.md
[appveyor]: https://ci.appveyor.com/project/pharo-graphics/bloc
[coveralls]: https://coveralls.io/github/pharo-graphics/Bloc?branch=master
[jenkins]: https://ci.inria.fr/pharo-contribution/job/Bloc/
[docpdf]: https://ci.inria.fr/pharo-contribution/job/PharoBookWorkInProgress/lastSuccessfulBuild/artifact/book-result/Bloc/Bloc.pdf
[dochtml]: https://ci.inria.fr/pharo-contribution/job/PharoBookWorkInProgress/lastSuccessfulBuild/artifact/book-result/Bloc/Bloc.html
