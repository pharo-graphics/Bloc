Class {
	#name : #BlNeutralAnchor,
	#superclass : #BlElementGeometryAnchor,
	#instVars : [
		'neutralValue'
	],
	#category : #'Bloc-Layout-Anchor'
}

{ #category : #applying }
BlNeutralAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ aRectangle
]

{ #category : #accessing }
BlNeutralAnchor >> neutralValue [

	^ neutralValue
]

{ #category : #accessing }
BlNeutralAnchor >> neutralValue: anObject [

	neutralValue := anObject
]

{ #category : #applying }
BlNeutralAnchor >> valueInBounds: aBounds [

	^ neutralValue
]
