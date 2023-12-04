Class {
	#name : 'BlTestMouseEventProcessor',
	#superclass : 'BlMouseProcessor',
	#instVars : [
		'firedEvents'
	],
	#category : 'Bloc-Tests-Universe',
	#package : 'Bloc-Tests',
	#tag : 'Universe'
}

{ #category : 'as yet unclassified' }
BlTestMouseEventProcessor >> dispatchEvent: anEvent target: aTarget [
	firedEvents add: anEvent
]

{ #category : 'as yet unclassified' }
BlTestMouseEventProcessor >> fireEvent: anEvent [
	firedEvents add: anEvent.

	^ super fireEvent: anEvent
]

{ #category : 'accessing' }
BlTestMouseEventProcessor >> firedEvents [
	^ firedEvents
]

{ #category : 'as yet unclassified' }
BlTestMouseEventProcessor >> initialize [
	super initialize.
	firedEvents := LinkedList new.
	
]
