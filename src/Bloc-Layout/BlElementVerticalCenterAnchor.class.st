Class {
	#name : #BlElementVerticalCenterAnchor,
	#superclass : #BlElementAxisAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementVerticalCenterAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| h y1 |
	h := aRectangle height // 2.
	y1 := aValue - h.
	^ Rectangle
		  origin: aRectangle origin x @ y1
		  corner: aRectangle corner x @ (y1 + aRectangle height)
]

{ #category : #applying }
BlElementVerticalCenterAnchor >> valueInBounds: aBounds [

	^ aBounds center y
]
