# Bloc

[Installation](#installation) | [Contributing](#contributing) |  [License](#license)

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg?style=flat-square)][license]
[![Travis](https://img.shields.io/travis/pharo-graphics/Bloc.svg?style=flat-square)][travis]
[![AppVeyor](https://img.shields.io/appveyor/ci/pharo-graphics/Bloc.svg?style=flat-square)][appveyor]
[![Coveralls](https://img.shields.io/coveralls/pharo-graphics/Bloc.svg?style=flat-square)][coveralls]

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

This repository contains the code for Bloc that may be included in the future in Pharo.
It retrofits a part of the development made at http://github.com/feenkcom/bloc.
This version may contain less features and evolve slower. We are currently identifying the core we want for Pharo.

## Installation

The following script installs Bloc intended for [Pharo 8](https://pharo.org/download):<br>

```smalltalk
Metacello new
        baseline: 'Bloc';
        repository: 'github://feenkcom/Bloc/src';
        load
```

## Contributing

Want to contribute on Bloc? Awesome!
We have [instructions to help you get started contributing code or documentation][contributing].

## License

Licensed under the [MIT license][license].

[license]: ./LICENSE
[contributing]: ./CONTRIBUTING.md
