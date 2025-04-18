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
BlProportionalLayout >> boundsForChild: aChild in: availableBounds [

	| horizontalProportions verticalProportions result |
	horizontalProportions := aChild constraints proportional horizontal.
	verticalProportions := aChild constraints proportional vertical.

	result := BlBounds fromRectangle: availableBounds.
	
	result
		shrinkByLeft: availableBounds width * horizontalProportions left
		top: availableBounds height * verticalProportions top
		right: availableBounds width * (1.0 - horizontalProportions right)
		bottom: availableBounds height * (1.0 - verticalProportions bottom).

	result shrinkByMargin: aChild margin.
	result expand. "Convert to integer values"

	^ result
]

{ #category : #layout }
BlProportionalLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [

	| availableBounds |
	availableBounds := anElement padding
		inset: (0.0 @ 0.0 extent: anElement extent).

	"Layout non-ignoredByLayout children"
	anElement children accountedByLayout do: [ :eachChild |
		eachChild
			applyLayoutIn: (self
				boundsForChild: eachChild
				in: availableBounds)
			context: aBlElementBoundsUpdater ].

	"Layout ignoredByLayout children"		
	self layoutIgnored: anElement context: aBlElementBoundsUpdater
]

{ #category : #measure }
BlProportionalLayout >> measure: anElement with: anExtentSpec [

	| extent |
	extent := anExtentSpec sizeFor: 0.0 @ 0.0.
	anElement measuredExtent: extent.

	anElement children accountedByLayout do: [ :eachChild |
		
		| boundsForChild availableBounds |
		availableBounds := anElement padding inset: (0@0 extent: extent).
		boundsForChild := self boundsForChild: eachChild in: availableBounds.
				
		eachChild measure:
			(BlExtentMeasurementSpec
				widthSpec:
					(self
						measurementSpecFor: anExtentSpec widthSpec
						usedSize: extent x - boundsForChild width
						resizer: BlLayoutResizer matchParent)
				heightSpec:
					(self
						measurementSpecFor: anExtentSpec heightSpec
						usedSize: extent y - boundsForChild height
						resizer: BlLayoutResizer matchParent)) ].
	
	self measureIgnored: anElement with: anExtentSpec
]
