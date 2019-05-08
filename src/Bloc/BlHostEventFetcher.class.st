"
I am the abstract class for event queue management.

"
Class {
	#name : #BlHostEventFetcher,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'eventQueue'
	],
	#category : #'Bloc-Universe'
}

{ #category : #'event processing' }
BlHostEventFetcher >> enqueueEvent: aBlEvent [
	"Enqueue a given Bloc Event in the event queue.
	Do not use me directly, instead rely on #enqueueEvent: from HostSpace"

	eventQueue nextPut: aBlEvent
]

{ #category : #'event processing' }
BlHostEventFetcher >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
	| theEvents |

	theEvents := LinkedList new.
	eventQueue flush: [ :anEvent | theEvents add: anEvent ].
	theEvents do: aBlock
]

{ #category : #'initialize-release' }
BlHostEventFetcher >> initialize [
	super initialize.

	eventQueue := WaitfreeQueue new
]
