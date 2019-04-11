"
I contain examples of space related events
"
Class {
	#name : #BlSpaceEventExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'event handling' }
BlSpaceEventExamples >> ignoreSpaceEventsAfterCloseRequest [
	<gtExample>
	| aSpace |

	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace eventRecorder: BlMemoryEventRecorder new.
	aSpace show.

	aSpace hostSpace enqueueEvent: (BlSpaceCloseRequest new timestamp: DateAndTime now).
	aSpace hostSpace enqueueEvent: (BlTouchMoveEvent new
		position: 50@50;
		screenPosition: 50@50;
		delta: 10@10;
		timestamp: DateAndTime now;
		pointerId: 1;
		pressure: 1;
		yourself).

	aSpace pulse.
	
	self assert: aSpace eventRecorder events size equals: 1.
	"event recorder stores copies of events"
	self assert: (aSpace eventRecorder events first isKindOf: BlSpaceCloseRequest).

	^ aSpace
]

{ #category : #'instance creation' }
BlSpaceEventExamples >> space [
	<gtExample>
	
	^ BlSpace new
]

{ #category : #'show / close' }
BlSpaceEventExamples >> spaceClosed [
	<gtExample>
	| aSpace spaceClosed |
	spaceClosed := 0.
	
	aSpace := self space.
	aSpace addEventHandlerOn: BlSpaceClosedEvent do: [ spaceClosed := spaceClosed + 1 ].
	
	aSpace show.
	self assert: spaceClosed equals: 0.
	aSpace close.
	self assert: spaceClosed equals: 1.
	
	^ aSpace
]

{ #category : #'show / close' }
BlSpaceEventExamples >> spaceShown [
	<gtExample>
	| aSpace spaceShown |
	spaceShown := 0.
	
	aSpace := self space.
	aSpace addEventHandlerOn: BlSpaceShownEvent do: [ spaceShown := spaceShown + 1 ].

	aSpace show.
	self assert: spaceShown equals: 1.

	aSpace close.
	self assert: spaceShown equals: 1.
	
	
	^ aSpace
]
