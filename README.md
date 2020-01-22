# Bloc

[Installation](#installation) | [Contributing](#contributing) |  [License](#license)

[![License](https://img.shields.io/github/license/feenkcom/Bloc.svg?style=flat-square)][license]

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

Main maintainers : [Glenn Cavarlé](https://github.com/GlennCavarle) & [Aliaksei Syrel](https://github.com/syrel)

## Installation

The following script installs Bloc intended for [Pharo 8](https://pharo.org/download):<br>

```smalltalk
[
    EpMonitor current disable.
    Metacello new
        baseline: 'Bloc';
        repository: 'github://feenkcom/Bloc/src';
        load
] ensure: [ EpMonitor current enable ]
```

## Contributing

Want to contribute on Bloc? Awesome!
We have [instructions to help you get started contributing code or documentation][contributing].

## License

Licensed under the [MIT license][license].

[license]: ./LICENSE
[contributing]: ./CONTRIBUTING.md
