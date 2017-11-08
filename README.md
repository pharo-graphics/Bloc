# Bloc

[Installation](#installation) | [Contributing](#contributing) |  [License](#license)

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg?style=flat-square)][license]
[![Travis](https://img.shields.io/travis/pharo-graphics/Bloc.svg?style=flat-square)][travis]
[![AppVeyor](https://img.shields.io/appveyor/ci/pharo-graphics/Bloc.svg?style=flat-square)][appveyor]
[![Coveralls](https://img.shields.io/coveralls/pharo-graphics/Bloc.svg?style=flat-square)][coveralls]

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

Main maintainers : [Glenn Cavarlé](https://github.com/GlennCavarle) & [Aliaksei Syrel](https://github.com/syrel)

## Installation

The following script installs a **stable** version of Bloc intended for [Pharo 6.1](https://pharo.org/download):<br>

```smalltalk
Metacello new
   baseline: 'Bloc';
   repository: 'github://pharo-graphics/Bloc:pharo6.1/src';
   load: #core
```

In order to install a **bleeding edge** version of Bloc you could use the following script:

```smalltalk
Metacello new
   baseline: 'Bloc';
   repository: 'github://pharo-graphics/Bloc/src';
   load: #core
```

**More detailed installation guide is described [here](INSTALL.md)**

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
