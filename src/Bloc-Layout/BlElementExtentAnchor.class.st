Class {
	#name : #BlElementExtentAnchor,
	#superclass : #BlElementGeometryAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementExtentAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ BlBounds origin: aRectangle origin extent: aValue
]

{ #category : #testing }
BlElementExtentAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
BlElementExtentAnchor >> valueInBounds: aBounds [

	^ aBounds extent
]
