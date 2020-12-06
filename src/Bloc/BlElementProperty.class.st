"
!Style property
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

{ #category : #'api - property' }
BlElementProperty >> maybeApplyOnElement: anElement [
	self applyOnElement: anElement
]

{ #category : #'api - property' }
BlElementProperty >> maybeCleanUpOnElement: anElement [
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
