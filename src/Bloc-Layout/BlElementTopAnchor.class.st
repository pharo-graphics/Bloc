Class {
	#name : #BlElementTopAnchor,
	#superclass : #BlElementEdgeAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementTopAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	y := aValue - (self valueInBounds: aRectangle).
	x := aRectangle left.
	^ Rectangle
		  origin: x @ y
		  corner: (x + aRectangle width) @ (y + aRectangle height)
]

{ #category : #applying }
BlElementTopAnchor >> valueInBounds: aBounds [

	^ aBounds top
]
