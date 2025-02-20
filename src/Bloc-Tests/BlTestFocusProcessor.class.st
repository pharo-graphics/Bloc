Class {
	#name : #BlTestFocusProcessor,
	#superclass : #BlFocusProcessor,
	#instVars : [
		'firedEvents'
	],
	#category : #'Bloc-Tests-Universe'
}

{ #category : #removing }
BlTestFocusProcessor >> clearFiredEvents [

	firedEvents removeAll
]

{ #category : #'event firing' }
BlTestFocusProcessor >> dispatchEvent: anEvent target: aTarget [

	firedEvents add: anEvent.
	
	^ super dispatchEvent: anEvent target: aTarget
]

{ #category : #'event firing' }
BlTestFocusProcessor >> fireEvent: anEvent [

	firedEvents add: anEvent.

	^ super fireEvent: anEvent
]

{ #category : #'event firing' }
BlTestFocusProcessor >> fireEvent: anEvent from: aTopEventTarget [

	firedEvents add: anEvent.
	
	^ super fireEvent: anEvent from: aTopEventTarget
]

{ #category : #accessing }
BlTestFocusProcessor >> firedEvents [

	^ firedEvents
]

{ #category : #initialization }
BlTestFocusProcessor >> initialize [

	super initialize.
	firedEvents := LinkedList new
]
