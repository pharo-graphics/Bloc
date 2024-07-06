# Bloc 

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg)](./LICENSE)
[![Tests](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml)

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

:warning:
This repository contains the code for Bloc that will included in the future in Pharo.
It retrofits a part of the development made at https://github.com/feenkcom/bloc. This version will focus on core features and stability. We are currently identifying the core we want for Pharo.

You can join the mailing-list lse-openbloc@inria.fr from http://sympa.inria.fr.

## Installation

Use the following script to install stable Bloc in stable [Pharo](https://pharo.org/download):

```smalltalk
[ Metacello new
	baseline: 'Bloc';
	repository: 'github://pharo-graphics/Bloc:master/src';
	onConflictUseIncoming;
	ignoreImage;
	load ]
		on: MCMergeOrLoadWarning
		do: [ :warning | warning load ]
```

You can replace `master` by: 
* `dev` to work on the development branch
* `v2.0.0-alpha` to load a released version


## Getting Started

We count with [a great tutorial](https://github.com/SquareBracketAssociates/Booklet-ASimpleMemoryGame) to get your first journey in Bloc by creating a simple memory game.

Additionally, we provide the following sequence of scripts, as a first glance on Bloc basic concepts, terminology and API:

1. Open a new window (a Bloc _space_, `BlSpace`):
```smalltalk
aSpace := BlSpace new.
aSpace show.

"Edit the space's properties, like title and size"
aSpace title: 'Bloc basics'.
aSpace extent: 800 @ 600.
```

2. Add a first _element_ (`BlElement`) to the space's _root_:
```smalltalk
"Create a red rectangle"
rectangle := BlElement new 
	background: Color red; 
	size: 150 @ 150;
	yourself.
	
"Add it to the space"
aSpace root addChild: rectangle.

"Update its properties"
rectangle 
	background: Color lightBlue;
	position: 100 @ 100;
	border: (BlBorder paint: Color blue width: 10).
```

3. Nest an element with circle _geometry_ (in `BlElementGeometry` hierarchy):
```smalltalk
circle := BlElement new
	background: Color blue;
	geometry: BlCircleGeometry new;
	size: 80 @ 80;
	yourself.
rectangle addChild: circle.
```

4. Turn off _clipping_ to show children overflow:
```smalltalk
rectangle clipChildren: false.
```

5. Transform child (to resize it):
```smalltalk
circle transformDo: [ :builder | builder scaleBy: 1.2 ].
```

6. Play some _animations_:
```smalltalk
"Animate opacity"
rectangle addAnimation: (BlOpacityAnimation new opacity: 0.5).

"Animate transformations"
fallAnimation := (BlTransformAnimation translate: 0 @ 200) absolute.
rectangle addAnimation: fallAnimation.
climbAnimation := (BlTransformAnimation translate: 0 @ 0) absolute.
rectangle addAnimation: climbAnimation.

"Create a sequence of animations"
animationSequence := BlSequentialAnimation withAll: { fallAnimation. climbAnimation }.
animationSequence beInfinite.
rectangle addAnimation: animationSequence
```

7. Handle some _events_:
```smalltalk
"Change color on click"
rectangle addEventHandlerOn: BlClickEvent do: [ :event | event target background: Color lightGray ].

"Animate on hover"
rectangle 
	addEventHandlerOn: BlMouseEnterEvent
	do: [ :event | event target addAnimation: (BlOpacityAnimation new opacity: 0.2) ];
	addEventHandlerOn: BlMouseLeaveEvent 
	do: [ :event | event target addAnimation: (BlOpacityAnimation new opacity: 1.0) ] 
```

## License and Contributing

This code is licensed under the [MIT license](./LICENSE).

If you want to contribute to the project, please read our [contributing guide](./CONTRIBUTING.md).
