Class {
	#name : #BlElementLeftAnchor,
	#superclass : #BlElementEdgeAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementLeftAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	x := aValue - (self valueInBounds: aRectangle).
	y := aRectangle top.
	^ BlBounds
		  origin: x @ y
		  corner: (x + aRectangle width) @ (y + aRectangle height)
]

{ #category : #applying }
BlElementLeftAnchor >> valueInBounds: aBounds [

	^ aBounds left
]
