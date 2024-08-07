"
I'm a layout that determines the position and extent of each child of an element by taking into account fractions defined in the constraints.

I was initially inspired on Morphic's ProportionalLayout.

Example:
```
	| aContainer childA childB gap |
	gap := 5.

	childA := BlElement new
		id: #childA;
		background: Color red;
		constraintsDo: [ :c |
			c proportional horizontal right: 0.5.
			c margin: (BlInsets all: gap) ];
		yourself.

	childB := BlElement new
		id: #childB;
		background: Color green;
		constraintsDo: [ :c |
			c proportional horizontal left: 0.5.
			c margin: (BlInsets all: gap) ];
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
		padding: (BlInsets all: gap);
		yourself.
	
	aContainer openInNewSpace
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

	| horizontalProportions verticalProportions result |
	horizontalProportions := aChild constraints proportional horizontal.
	verticalProportions := aChild constraints proportional vertical.

	result := BlBounds fromRectangle: parentBounds.
	
	result
		shrinkByLeft: parentBounds width * horizontalProportions left
		top: parentBounds height * verticalProportions top
		right: parentBounds width * (1.0 - horizontalProportions right)
		bottom: parentBounds height * (1.0 - verticalProportions bottom).

	result
		shrinkByLeft: aChild margin left
		top: aChild margin top
		right: aChild margin right
		bottom: aChild margin bottom.

	result expanded. "Convert to integer values"

	^ result
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
			context: aBlElementBoundsUpdater ].
		
	self layoutIgnored: anElement context: aBlElementBoundsUpdater
]

{ #category : #measure }
BlProportionalLayout >> measure: anElement with: anExtentSpec [
	super measure: anElement with: anExtentSpec.
	
	self measureIgnored: anElement with: anExtentSpec
]
