"
!Element property
"
Class {
	#name : #BlElementProperty,
	#superclass : #Object,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementProperty >> applyOnElement: anElement [
]

{ #category : #testing }
BlElementProperty >> canPropagateToChildren [
	^ false
]

{ #category : #'api - property' }
BlElementProperty >> cleanUpOnElement: anElement [
]

{ #category : #private }
BlElementProperty >> maybeApplyOnElement: anElement [
	"Private method to be polymorphic with a property with status"

	self applyOnElement: anElement
]

{ #category : #private }
BlElementProperty >> maybeCleanUpOnElement: anElement [
	"Private method to be polymorphic with a property with status"
]

{ #category : #'api - property' }
BlElementProperty >> property [
	^ self
]

{ #category : #'api - property' }
BlElementProperty >> resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties [
	^ self
]

{ #category : #'api - property' }
BlElementProperty >> type [
	^ self class
]
