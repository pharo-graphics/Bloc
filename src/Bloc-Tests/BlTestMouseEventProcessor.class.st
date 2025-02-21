Class {
	#name : #BlTestMouseEventProcessor,
	#superclass : #BlMouseProcessor,
	#instVars : [
		'firedEvents'
	],
	#category : #'Bloc-Tests-Universe'
}

{ #category : #'as yet unclassified' }
BlTestMouseEventProcessor >> dispatchEvent: anEvent target: aTarget [

	firedEvents add: anEvent
]

{ #category : #'as yet unclassified' }
BlTestMouseEventProcessor >> fireEvent: anEvent [

	firedEvents add: anEvent.

	^ super fireEvent: anEvent
]

{ #category : #accessing }
BlTestMouseEventProcessor >> firedEvents [

	^ firedEvents
]

{ #category : #initialization }
BlTestMouseEventProcessor >> initialize [

	super initialize.
	firedEvents := LinkedList new
]
