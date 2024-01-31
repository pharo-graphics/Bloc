"
I contain examples of space related events

"
Class {
	#name : 'BlSpaceEventTest',
	#superclass : 'TestCase',
	#instVars : [
		'space'
	],
	#category : 'Bloc-Examples-Event',
	#package : 'Bloc-Examples',
	#tag : 'Event'
}

{ #category : 'running' }
BlSpaceEventTest >> setUp [
	super setUp.

	space :=
		BlSpace new
		  host: BlHeadlessHost new;
		  yourself
]

{ #category : 'event handling' }
BlSpaceEventTest >> testIgnoreSpaceEventsAfterCloseRequest [
	<expectedFailure>

	space eventRecorder: BlMemoryEventRecorder new.
	space show.

	space hostSpace enqueueEvent:
		(BlSpaceCloseRequest new timestamp: DateAndTime now).

	self assert: space hasHostSpace not
]

{ #category : 'show / close' }
BlSpaceEventTest >> testSpaceClosed [
	<expectedFailure>

	| count |
	count := 0.

	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ count := count + 1 ].

	space show.
	self assert: count equals: 0.
	space close.
	self assert: count equals: 1
]

{ #category : 'show / close' }
BlSpaceEventTest >> testSpaceDestroyed [
	<expectedFailure>

	| events |
	events := OrderedCollection new.

	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ events add: #closed ].
	space
		addEventHandlerOn: BlSpaceDestroyedEvent
		do: [ events add: #destroyed ].

	space show.
	self assert: events size equals: 0.
	space close.
	self assert: events size equals: 2.
	self assert: events asArray equals: #( closed destroyed )
]

{ #category : 'show / close' }
BlSpaceEventTest >> testSpaceShown [
	<expectedFailure>

	| spaceShown |
	spaceShown := 0.

	space
		addEventHandlerOn: BlSpaceShownEvent
		do: [ spaceShown := spaceShown + 1 ].

	space show.
	self assert: spaceShown equals: 1.

	space close.
	self assert: spaceShown equals: 1
]
