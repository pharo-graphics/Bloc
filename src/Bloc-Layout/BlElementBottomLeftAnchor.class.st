Class {
	#name : #BlElementBottomLeftAnchor,
	#superclass : #BlElementCornerAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementBottomLeftAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	x := aValue x.
	y := aValue y - aRectangle height.
	^ BlBounds
		  origin: x @ y
		  extent: aRectangle extent
]

{ #category : #applying }
BlElementBottomLeftAnchor >> valueInBounds: aBounds [

	^ aBounds bottomLeft
]
