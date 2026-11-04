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
- v3.0.0 to load a released version

## How to depend on it

Add this project to your Baseline with:

```smalltalk
spec baseline: 'Bloc' with: [ spec repository: 'github://pharo-graphics/Bloc:master/src' ].
```

## Core Concepts

Bloc is built on four central abstractions:
- **`BlElement`**: The fundamental visual building block. Elements are organized in a scene tree (parents, children). Each element has geometry (rectangle, circle, polygon), styling (background, border, opacity), event handlers, and layout constraints.
- **`BlSpace`**: Represents an active window or surface. A space owns the root of the scene graph (`space root`).
- **`BlHost`**: Bridges a space to the operating system or windowing backend (e.g. SDL3, OSWindow, Morphic, or Headless for tests).
- **Pulse Process**: Each opened space is driven by a background host process that continuously runs frame cycles (events, tasks, layout, rendering).

### Playground Quickstart

```smalltalk
space := BlSpace new.
space extent: 400 @ 300.

box := BlElement new
	extent: 150 @ 150;
	background: Color red;
	border: (BlBorder paint: Color darkGray width: 2);
	yourself.

space root addChild: box.
space open.
```

## Documentation

The guides are arranged in recommended reading order:

### Core Guides
1. [Getting Started](doc/1-GettingStarted.md) — Visual basics: elements, geometry, styling, and basic events.
2. [Concurrency and Synchronization](doc/2-ConcurrencyAndSynchronization.md) — The host pulse loop, frame phases, and the `settle` & `defer:` synchronization API.
3. [Building Non-Blocking UIs](doc/3-BuildingNonBlockingUIs.md) — Practical patterns for background workers, futures, progress feedback, and data streams.

### Topic Guides & Reference
- [Layout and Constraints](doc/LayoutAndConstraints.md) — Size policies, layout facets, why `position:` is a request, and reacting to a layout without looping.
- [Working with Text](doc/Text.md) — `BlTextElement`, what it does not do (wrapping, line breaks), and recipes: lines, wrapping, ellipsis.
- [Graphical Patterns: Zoom, Pan and Fit](doc/GraphicalPatterns.md) — Transformations and the patterns to zoom around the mouse, pan with the mouse and fit a content in a window.
- [Testing Interactions and Drawing](doc/TestingInteractions.md) — Headless host, synthetic mouse events (`fireEvent:` vs `dispatchEvent:`) and checking pixels.
- [Troubleshooting](doc/Troubleshooting.md) — Symptoms and explanations, including the debugger that freezes the windows.
- [Using Bloc in a Spec Presenter](doc/SpecIntegration.md) — Showing a Bloc space in a Spec window with `SpBlSpaceInMorphPresenter`.
- [About Mouse Events](doc/MouseEvent.md) — Event dispatching: enter/leave vs over/out bubbling.
- [Understanding Scene Graph Attachment](doc/ElementAddedToSceneGraph.md) — Working with `BlElement >> #onAddedToSceneGraph`.
- [History and Presentations](doc/History.md) — Evolution of Bloc and recorded talks.

These pages can also be browsed inside Pharo: **World Menu > Help > Documentation Browser > Bloc/doc**.

### External Tutorials & Booklets
- **[A Simple Memory Game Booklet](https://github.com/SquareBracketAssociates/Booklet-ASimpleMemoryGame)**: A step-by-step tutorial building a complete memory game in Bloc (Square Bracket Associates).
- **[Booklet-Graphics](https://github.com/SquareBracketAssociates/Booklet-Graphics)**: The broader Pharo graphics booklet covering Athens, geometry, and graphical pipelines.

## Examples

Several options:
* Open the Demo browser via Pharo IDE -> World Menu -> Library -> Bloc -> Bloc demo browser
* Browse Bloc's `-Examples` packages
* Browse related projects that use Bloc such as Toplo, BlocBenchs, Pyramid, Coypu.

## Contact

Want to write us? you are welcome! you can either:
* Join the mailing-list lse-openbloc@inria.fr from http://sympa.inria.fr
* Chat via Discord in the #bloc channel of the Pharo server


## Branches & Contributions

We describe our contribution workflow & branch name convention in [this wiki page](../../wiki/Branches-and-versions).


## License

This code is licensed under the [MIT license](./LICENSE).
