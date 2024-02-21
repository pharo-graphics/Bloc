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
Open a new window (a Bloc _space_) 
```smalltalk
aSpace := BlSpace new.
aSpace show.

"Edit the space's properties, like title and size"
aSpace title: 'Bloc basics'.
aSpace extent: 800 @ 600.
```

Draw an element (a `BlElement`)
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

Nesting elements
```smalltalk
"Create a circle using a geometry (a BlElementGeometry subclass)"
circle := BlElement new
	background: Color blue;
	geometry: BlCircleGeometry new;
	size: 80 @ 80;
	yourself.
rectangle addChild: circle.

"Use a transformation to resize and show child element's overflow"
circle transformDo: [ :builder | builder scaleBy: 1.2 ].
rectangle clipChildren: false
```

Animating
```smalltalk
"Animate opacity"
rectangle addAnimation: (BlOpacityAnimation new opacity: 0.5).

"Animate transformations"
fallAnimation := (BlTransformAnimation translate: 0 @ 200) absolute.
rectangle addAnimation: fallAnimation.
climbAnimation := (BlTransformAnimation translate: 0 @ 0) absolute.
rectangle addAnimation: climbAnimation.

"Create sequence of animations"
animationSequence := (BlSequentialAnimation withAll: {fallAnimation . climbAnimation})
	beInfinite;
	yourself.
rectangle addAnimation: animationSequence
```

Handling Events
```smalltalk
"Change color on click"
rectangle addEventHandlerOn: BlClickEvent do: [ :event | event target background: Color lightGray ].

"Animate on hover/blur"
rectangle 
	addEventHandlerOn: BlMouseEnterEvent
	do: [ :event | event target addAnimation: (BlOpacityAnimation new opacity: 0.2)];
	addEventHandlerOn: BlMouseLeaveEvent 
	do: [ :event | event target addAnimation: (BlOpacityAnimation new opacity: 0.8)] 
```

## License and Contributing

This code is licensed under the [MIT license](./LICENSE).

If you want to contribute to the project, please read our [contributing guide](./CONTRIBUTING.md).
