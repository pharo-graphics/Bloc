Class {
	#name : #BlNullTelemetry,
	#superclass : #BlTelemetry,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Space - Telemetry'
}

{ #category : #accessing }
BlNullTelemetry class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlNullTelemetry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'instance creation' }
BlNullTelemetry >> emit [
]
