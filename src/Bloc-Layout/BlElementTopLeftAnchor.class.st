Class {
	#name : #BlElementTopLeftAnchor,
	#superclass : #BlElementCornerAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementTopLeftAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	x := aValue x.
	y := aValue y.
	^ BlBounds
		  origin: x @ y
		  extent: aRectangle extent
]

{ #category : #applying }
BlElementTopLeftAnchor >> valueInBounds: aBounds [

	^ aBounds topLeft
]
