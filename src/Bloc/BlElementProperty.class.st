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
BlElementProperty >> resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties [
	^ self
]

{ #category : #'api - property' }
BlElementProperty >> type [
	^ self class
]
