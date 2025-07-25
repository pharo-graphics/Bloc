Class {
	#name : #BlElementRightAnchor,
	#superclass : #BlElementEdgeAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementRightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| x y |
	x := aValue - aRectangle width.
	y := aRectangle top.
	^ BlBounds
		  origin: x @ y
		  corner: x + aRectangle width @ (y + aRectangle height)
]

{ #category : #applying }
BlElementRightAnchor >> valueInBounds: aBounds [

	^ aBounds right
]
