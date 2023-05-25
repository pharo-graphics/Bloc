"
I'm a layout that determines the position and extent of each child of an element by taking into account fractions defined in the constraints.

I was initially inspired on Morphic's ProportionalLayout.

Example:
```
	| aContainer childA childB |
	childA := BlElement new
		id: #childA;
		background: Color red;
		constraintsDo: [ :c |
			c proportional horizontal rightFraction: 0.5 ];
		yourself.

	childB := BlElement new
		id: #childB;
		background: Color green;
		constraintsDo: [ :c |
			c proportional horizontal leftFraction: 0.5 ];
		yourself.

	aContainer := BlElement new
		id: #container;
		background: Color blue;
		layout: BlProportionalLayout new;
		size: 100 @ 100;
		addChild: childA;
		addChild: childB;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets all: 5);
		yourself.
	
	aContainer openInNewSpace.
```
"
Class {
	#name : #BlProportionalLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layout-Proportional'
}

{ #category : #constraints }
BlProportionalLayout class >> constraints [

	^ BlProportionalLayoutConstraints new
]

{ #category : #measure }
BlProportionalLayout >> boundsForChild: aChild in: parentBounds [

	| allowedBounds childBounds horizontalFractions verticalFractions |
	allowedBounds := aChild margin inset: parentBounds.
	horizontalFractions := aChild constraints proportional horizontal.
	verticalFractions := aChild constraints proportional vertical.

	childBounds :=
		BlBounds
			left: allowedBounds left +
				(allowedBounds width * horizontalFractions leftFraction) rounded
			top: allowedBounds top +
				(allowedBounds height * verticalFractions topFraction) rounded
			right: allowedBounds right -
				(allowedBounds width * (1.0 - horizontalFractions rightFraction)) rounded
			bottom: allowedBounds bottom -
				(allowedBounds height * (1.0 - verticalFractions bottomFraction)) rounded.

	^ childBounds
]

{ #category : #measure }
BlProportionalLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [

	| parentBounds |
	parentBounds := anElement padding
		inset: (0.0 @ 0.0 extent: anElement extent).

	anElement children accountedByLayout do: [ :eachChild |
		eachChild
			applyLayoutIn: (self
				boundsForChild: eachChild
				in: parentBounds)
			context: aBlElementBoundsUpdater ]
]
