Class {
	#name : #BlElementPropertyWithStatus,
	#superclass : #Object,
	#instVars : [
		'property',
		'status'
	],
	#classVars : [
		'Applied',
		'JustAdded',
		'ToBeRemoved'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'class initialization' }
BlElementPropertyWithStatus class >> initialize [
	JustAdded := 1 << 0.
	ToBeRemoved := 1 << 2.
	Applied := 1 << 3.
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> addApplied [
	status := status | Applied
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> addJustAdded [
	status := status | JustAdded
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> addToBeRemoved [
	status := status | ToBeRemoved
]

{ #category : #testing }
BlElementPropertyWithStatus >> canPropagateToChildren [
	^ self property canPropagateToChildren and: [ self isToBeRemoved not ]
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> clearApplied [
	status := status & Applied bitInvert
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> clearJustAdded [
	status := status & JustAdded bitInvert
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> clearToBeRemoved [
	status := status & ToBeRemoved bitInvert
]

{ #category : #initialization }
BlElementPropertyWithStatus >> initialize [
	super initialize.
	
	status := 0
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> isApplied [
	^ 0 ~= (status & Applied) 
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> isJustAddded [
	^ 0 ~= (status & JustAdded) 
]

{ #category : #'private - status' }
BlElementPropertyWithStatus >> isToBeRemoved [
	^ 0 ~= (status & ToBeRemoved) 
]

{ #category : #'api - property' }
BlElementPropertyWithStatus >> maybeApplyOnElement: anElement [
	self isToBeRemoved
		ifFalse: [
			self isApplied
				ifFalse: [
					self property applyOnElement: anElement.
					status := Applied ] ]
]

{ #category : #'api - property' }
BlElementPropertyWithStatus >> maybeCleanUpOnElement: anElement [
	self isToBeRemoved
		ifTrue: [
			self isApplied
				ifTrue: [
					self property cleanUpOnElement: anElement.
					self clearApplied ] ]
]

{ #category : #printing }
BlElementPropertyWithStatus >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' property: ';
		print: property.
	aStream
		nextPutAll: ' status: ';
		print: status
]

{ #category : #accessing }
BlElementPropertyWithStatus >> property [
	^ property
]

{ #category : #accessing }
BlElementPropertyWithStatus >> property: anObject [
	property := anObject
]

{ #category : #'api - property' }
BlElementPropertyWithStatus >> resolveWithParentProperties: theParentProperties orGlobal: theGlobalProperties [
	<return: #BlElementPropertyWithStatus>
	| aResolvedProperty |

	aResolvedProperty := self property
		resolveWithParentProperties: theParentProperties
		orGlobal: theGlobalProperties.

	aResolvedProperty = self property
		ifTrue: [ ^ self ].

	^ BlElementPropertyWithStatus new
		property: aResolvedProperty
]
