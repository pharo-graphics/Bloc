# Bloc

[Installation](#installation) | [Contributing](#contributing) |  [License](#license)

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg?style=flat-square)][license]

[![Coveralls](https://img.shields.io/coveralls/pharo-graphics/Bloc.svg?style=flat-square)][coveralls]

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

:warning:
This repository contains the code for Bloc that may be included in the future in Pharo.
It retrofits a part of the development made at http://github.com/feenkcom/bloc.  
This version will focus on core features and stability.  
We are currently identifying the core we want for Pharo.

## Installation

The following script installs Bloc intended for [Pharo 8](https://pharo.org/download):

To load the most bare bone bloc (just Bloc , BlocHost-Mock and Bloc-Tests packages):
```smalltalk
Metacello new
        baseline: 'BlocCore';
        repository: 'github://pharo-graphics/Bloc/src';
        load
```

To also load a rendering engine we can use the following baseline which in addition to BlocCore also loads Bloc-Text and Bloc-Sparta:

```
Metacello new
    baseline: 'BlocSparta';
    repository: 'github://pharo-graphics/Bloc/src';
    load.
```


## Contributing

Want to contribute on Bloc? Awesome!
We have [instructions to help you get started contributing code or documentation][contributing].

## License

Licensed under the [MIT license][license].

[license]: ./LICENSE
[contributing]: ./CONTRIBUTING.md
