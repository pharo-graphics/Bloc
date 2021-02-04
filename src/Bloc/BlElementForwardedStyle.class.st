Class {
	#name : #BlElementForwardedStyle,
	#superclass : #BlElementStyle,
	#instVars : [
		'targetObject'
	],
	#category : #'Bloc-Basic-Style'
}

{ #category : #actions }
BlElementForwardedStyle >> applyOnElement: anElement [
	(targetObject asBlocResolvedElementsFrom: anElement) asCollection
		do: [ :eachTargetObject | eachTargetObject properties addProperties: self properties ]
]

{ #category : #converting }
BlElementForwardedStyle >> asForwarded: aTargetObject [
	^ self targetObject == aTargetObject
		ifTrue: [ self ]
		ifFalse: [ super asForwarded: aTargetObject ]
]

{ #category : #actions }
BlElementForwardedStyle >> cleanUpOnElement: anElement [
	(targetObject asBlocResolvedElementsFrom: anElement) asCollection
		do: [ :eachTargetObject | eachTargetObject properties removeProperties: self properties ]
]

{ #category : #testing }
BlElementForwardedStyle >> isForwarded [
	^ true
]

{ #category : #accessing }
BlElementForwardedStyle >> targetObject [
	^ targetObject
]

{ #category : #accessing }
BlElementForwardedStyle >> targetObject: anObjectOrBlock [
	self
		assert: [ anObjectOrBlock notNil ]
		description: [ 'Target object must not be nil' ].

	targetObject := anObjectOrBlock
]
