Class {
	#name : #BlElementCenterAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementCenterAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| pt |
	pt := aValue - (aRectangle extent / 2).
	^ BlBounds origin: pt extent: aRectangle extent
]

{ #category : #applying }
BlElementCenterAnchor >> valueInBounds: aBounds [

	^ aBounds center
]
