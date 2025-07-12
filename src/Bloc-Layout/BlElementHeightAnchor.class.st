Class {
	#name : #BlElementHeightAnchor,
	#superclass : #BlElementAxisAnchor,
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlElementHeightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ BlBounds origin: aRectangle origin extent: aRectangle width @ aValue 
]

{ #category : #testing }
BlElementHeightAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
BlElementHeightAnchor >> valueInBounds: aBounds [

	^ aBounds height
]
