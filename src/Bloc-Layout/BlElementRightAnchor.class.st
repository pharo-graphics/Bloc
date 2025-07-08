Class {
	#name : #BlElementRightAnchor,
	#superclass : #BlElementEdgeAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementRightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	x := aValue - (self valueInBounds: aRectangle).
	y := aRectangle top.
	^ Rectangle
		  origin: x @ y
		  corner: (x + aRectangle width) @ (y + aRectangle height)
]

{ #category : #applying }
BlElementRightAnchor >> valueInBounds: aBounds [

	^ aBounds right
]
