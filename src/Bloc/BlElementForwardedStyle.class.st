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
	(targetObject isClosure and: [ targetObject argumentCount > 0 ])
		ifTrue: [
			targetObject value: [ :eachResolvedTargetObject |
				eachResolvedTargetObject properties addProperties: self properties ] ]
		ifFalse: [
			| aResolvedTargetObject |
			
			aResolvedTargetObject := targetObject value.
			"the object is maybe not yet created"
			aResolvedTargetObject
				ifNil: [ ^ self ].
			
			aResolvedTargetObject properties addProperties: self properties ]
]

{ #category : #converting }
BlElementForwardedStyle >> asForwarded: aTargetObject [
	^ self targetObject == aTargetObject
		ifTrue: [ self ]
		ifFalse: [ super asForwarded: aTargetObject ]
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
