Class {
	#name : #BlElementHorizontalCenterAnchor,
	#superclass : #BlElementAxisAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementHorizontalCenterAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| w x1 |
	w := aRectangle width // 2.
	x1 := aValue - w.
	^ Rectangle
		  origin: x1 @ aRectangle origin y
		  corner: (x1 + aRectangle width) @ aRectangle corner y
]

{ #category : #applying }
BlElementHorizontalCenterAnchor >> valueInBounds: aBounds [

	^ aBounds center x
]
