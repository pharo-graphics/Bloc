Class {
	#name : #BlElementVisibilityProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'visibility'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementVisibilityProperty >> applyOnElement: anElement [
	anElement visibility: self visibility
]

{ #category : #accessing }
BlElementVisibilityProperty >> visibility [
	^ visibility
]

{ #category : #accessing }
BlElementVisibilityProperty >> visibility: anObject [
	visibility := anObject
]
