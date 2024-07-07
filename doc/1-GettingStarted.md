# Getting Started

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
