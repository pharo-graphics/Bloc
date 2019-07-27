Class {
	#name : #BlUniverseEventListener,
	#superclass : #BlBasicEventHandler,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'lastTime'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #'as yet unclassified' }
BlUniverseEventListener >> eventsArrived: anEvent [
]

{ #category : #'as yet unclassified' }
BlUniverseEventListener >> eventsCleared: anEvent [
	| nowTime |
	"Once all events are handled it is time to tell spaces to redraw themselves"
	
	nowTime := DateAndTime now.
	lastTime := lastTime ifNil: [ nowTime ].
	
	anEvent currentTarget pulse.

	(nowTime - lastTime) < 16 milliSeconds
		ifTrue: [
			| aTimeToWait |

			aTimeToWait := (16 milliSeconds - (nowTime - lastTime)) / 2.0.
			10 atRandom = 5 ifTrue: [ aTimeToWait wait ].

			Processor yield.
			Processor class relinquishProcessorForMicroseconds: aTimeToWait asMilliSeconds * 1000 ].
	lastTime := nowTime
]

{ #category : #'api - event managing' }
BlUniverseEventListener >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #'as yet unclassified' }
BlUniverseEventListener >> universeResumed: anEvent [
]

{ #category : #'as yet unclassified' }
BlUniverseEventListener >> universeSuspended: anEvent [
]

{ #category : #'api - event managing' }
BlUniverseEventListener >> wantsEvent: anEvent [
	^ anEvent isUniverseEvent
]
