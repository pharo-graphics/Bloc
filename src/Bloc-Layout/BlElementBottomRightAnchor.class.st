Class {
	#name : #BlElementBottomRightAnchor,
	#superclass : #BlElementCornerAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementBottomRightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| pt |
	pt := aValue - aRectangle extent.
	^ BlBounds
		  origin: pt
		  extent: aRectangle extent
]

{ #category : #applying }
BlElementBottomRightAnchor >> valueInBounds: aBounds [

	^ aBounds bottomRight
]
