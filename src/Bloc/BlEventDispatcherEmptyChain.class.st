"
I am an empty chain that does not dispatch events.
Basically, I implement a null object pattern and used as next or previous element in dispatcher chain if there is none

"
Class {
	#name : #BlEventDispatcherEmptyChain,
	#superclass : #BlEventDispatcherChain,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #cleanup }
BlEventDispatcherEmptyChain class >> cleanUp [

	super cleanUp.

	uniqueInstance := nil
]

{ #category : #accessing }
BlEventDispatcherEmptyChain class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'api - event managing' }
BlEventDispatcherEmptyChain >> dispatchEvent: anEvent [

	^ anEvent
]

{ #category : #'api - adding' }
BlEventDispatcherEmptyChain >> withNext: aBlEventDispatcher [

	^ BlEventDispatcherChain with: aBlEventDispatcher
]
