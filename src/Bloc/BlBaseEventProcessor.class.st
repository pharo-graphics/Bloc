Class {
	#name : #BlBaseEventProcessor,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'space'
	],
	#category : #'Bloc-Space - Events'
}

{ #category : #'as yet unclassified' }
BlBaseEventProcessor class >> space:  aSpace [
	^ self new
		space: aSpace;
		yourself
]

{ #category : #'event firing' }
BlBaseEventProcessor >> dispatchEvent: anEvent target: aTarget [
	aTarget dispatchEvent: anEvent
]

{ #category : #'event firing' }
BlBaseEventProcessor >> fireEvent: anEvent [
	<return: #BlEvent>

	^ BlEvent fireEvent: anEvent
]

{ #category : #'initialize-release' }
BlBaseEventProcessor >> onSpaceClosed [
	"React to space closed in order to clean up the state"
]

{ #category : #accessing }
BlBaseEventProcessor >> space [
	^ space
]

{ #category : #accessing }
BlBaseEventProcessor >> space: aSpace [
	space := aSpace
]

{ #category : #accessing }
BlBaseEventProcessor >> telemetry [
	<return: #BlTelemetry>

	^ self space
		ifNil: [ BlNullTelemetry uniqueInstance ]
		ifNotNil: [ :aSpace | aSpace telemetry ]
]
