"
I am the abstract class for event queue management

"
Class {
	#name : #BlHostEventFetcher,
	#superclass : #Object,
	#instVars : [
		'eventQueue',
		'hostSpace'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostEventFetcher class >> hostSpace: aBlHostSpace [

	^ self basicNew
		initializeWithHostSpace: aBlHostSpace;
		yourself
]

{ #category : #'event processing' }
BlHostEventFetcher >> enqueueEvent: aBlEvent [
	"Enqueue a given Bloc Event in the event queue.
	Do not use me directly, instead rely on #enqueueEvent: from HostSpace"

	eventQueue nextPut: aBlEvent.
	hostSpace space ifNotNil: [ :aSpace | aSpace requestNextPulse ]
]

{ #category : #'event processing' }
BlHostEventFetcher >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"

	| theEvents |
	theEvents := LinkedList new.
	eventQueue flush: [ :anEvent | theEvents add: anEvent ].
	theEvents do: aBlock
]

{ #category : #accessing }
BlHostEventFetcher >> hostSpace [

	^ hostSpace
]

{ #category : #'initialize-release' }
BlHostEventFetcher >> initializeWithHostSpace: aHostSpace [

	self initialize.

	eventQueue := WaitfreeQueue new.
	hostSpace := aHostSpace
]
