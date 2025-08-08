Class {
	#name : #BlElementTopRightAnchor,
	#superclass : #BlElementCornerAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementTopRightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	x := aValue x - aRectangle width.
	y := aValue y.
	^ BlBounds
		  origin: x @ y
		  extent: aRectangle extent
]

{ #category : #applying }
BlElementTopRightAnchor >> valueInBounds: aBounds [

	^ aBounds topRight
]
