Class {
	#name : #BlElementEffectProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'effect'
	],
	#category : 'Bloc-Basic-Properties'
}

{ #category : #comparing }
BlElementEffectProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ effect = anObject effect
]

{ #category : #'api - property' }
BlElementEffectProperty >> applyOnElement: anElement [
	anElement effect: self effect
]

{ #category : #'api - property' }
BlElementEffectProperty >> cleanUpOnElement: anElement [
	anElement effect: BlNullEffect new
]

{ #category : #accessing }
BlElementEffectProperty >> effect [
	^ effect
]

{ #category : #accessing }
BlElementEffectProperty >> effect: anObject [
	effect := anObject
]

{ #category : #comparing }
BlElementEffectProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ effect hash
]
