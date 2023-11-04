Class {
	#name : 'BlNullTelemetry',
	#superclass : 'BlTelemetry',
	#classInstVars : [
		'uniqueInstance'
	],
	#package : 'Bloc',
	#tag : 'Space - Telemetry'
}

{ #category : 'accessing' }
BlNullTelemetry class >> cleanUp [
	uniqueInstance := nil
]

{ #category : 'accessing' }
BlNullTelemetry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'comparing' }
BlNullTelemetry >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : 'instance creation' }
BlNullTelemetry >> emit [
]

{ #category : 'comparing' }
BlNullTelemetry >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self class hash
]
