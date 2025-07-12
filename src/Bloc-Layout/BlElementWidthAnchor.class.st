Class {
	#name : #BlElementWidthAnchor,
	#superclass : #BlElementAxisAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementWidthAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ BlBounds origin: aRectangle origin extent: aValue @ aRectangle height
]

{ #category : #testing }
BlElementWidthAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
BlElementWidthAnchor >> valueInBounds: aBounds [

	^ aBounds width
]
