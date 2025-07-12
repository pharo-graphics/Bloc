Class {
	#name : #BlElementBottomAnchor,
	#superclass : #BlElementEdgeAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementBottomAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	y := aValue - (self valueInBounds: aRectangle).
	x := aRectangle left.
	^ BlBounds
		  origin: x @ y
		  corner: (x + aRectangle width) @ (y + aRectangle height)
]

{ #category : #applying }
BlElementBottomAnchor >> valueInBounds: aBounds [

	^ aBounds bottom
]
