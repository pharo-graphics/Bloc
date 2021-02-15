# Bloc 

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg?style=flat-square)][license]
![Complete Test](https://github.com/pharo-graphics/Bloc/workflows/Complete%20Test/badge.svg)

[Installation](#installation) | [Contributing](#contributing) |  [License](#license)

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

:warning:
This repository contains the code for Bloc that may be included in the future in Pharo.
It retrofits a part of the development made at http://github.com/feenkcom/bloc.  
This version will focus on core features and stability.  
We are currently identifying the core we want for Pharo.

## Installation

The following script installs Bloc intended for [Pharo 8](https://pharo.org/download):

```smalltalk
Metacello new
        baseline: 'NewBloc';
        repository: 'github://pharo-graphics/Bloc/src';
        load.
```

Alternatively, you can do it by terminal (MacOS & linux). 
Create a directory and execute `<this_repo>/scripts/build.sh`, which first downloads the Pharo image and VM and then loads the project.


## Contributing

Want to contribute on Bloc? Awesome!
Get the latest versions, run the tests and you can start sending PR.

## License

Licensed under the [MIT license][license].

[license]: ./LICENSE
[contributing]: ./CONTRIBUTING.md
