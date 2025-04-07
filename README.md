# Bloc 

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg)](./LICENSE)
[![Tests](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml)

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

:warning:
This repository contains a Bloc codebase to be included in Pharo and thus focuses on core features and stability.
It retrofits a part of the development made at https://github.com/feenkcom/bloc.


## Install

The project can be loaded as usual via Metacello, using the `BaselineOfBloc` specification. To copy/paste a loading script. Use the following script to install stable Bloc in stable Pharo:

```smalltalk
Metacello new
	baseline: 'Bloc';
	repository: 'github://pharo-graphics/Bloc:master/src';
	load
```
You can replace master by:

- dev to work on the development branch
- v2.2.0 to load latest released version
Add this project to your Baseline with:

## How to depend on it

```smalltalk
spec baseline: 'Bloc' with: [ spec repository: 'github://pharo-graphics/Bloc:v2.2.0/src' ].
```

## Documentation

* [Getting Started](doc/1-GettingStarted.md)
* [About Mouse Events](doc/2-MouseEvent.md)
* [Understanding `BlElement>>#onAddedToSceneGraph`](doc/3-ElementAddedToSceneGraph.md)
* [History](doc/4-History.md)

These pages can be browsed via Pharo IDE -> World Menu -> Help -> Documentation Browser -> Bloc/doc (after loading the project).
Note that there is also a book under writing available at [https://github.com/SquareBracketAssociates/Booklet-Graphics](https://github.com/SquareBracketAssociates/Booklet-Graphics)


## Contact

Want to write us? you are welcome! you can either:
* Join the mailing-list lse-openbloc@inria.fr from http://sympa.inria.fr
* Chat via Discord in the #bloc channel of the Pharo server


## Branches & Contributions

We describe our contribution workflow & branch name convention in [this wiki page](../../wiki/Branches-and-versions).


## License

This code is licensed under the [MIT license](./LICENSE).
