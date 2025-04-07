"
I contain examples of space related events

"
Class {
	#name : #BlSpaceEventTest,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Tests-Events'
}

{ #category : #running }
BlSpaceEventTest >> setUp [
	super setUp.

	space :=
		BlSpace new
		  host: BlHeadlessHost new;
		  yourself
]

{ #category : #tests }
BlSpaceEventTest >> testSpaceClosed [

	| count |
	count := 0.

	space
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ count := count + 1 ].

	space show.
	self waitPulses.
	self assert: count equals: 0.

	space close.
	self waitPulses.
	self assert: count equals: 1
]

{ #category : #tests }
BlSpaceEventTest >> testSpaceShown [

	| count |
	count := 0.

	space
		addEventHandlerOn: BlSpaceShownEvent
		do: [ count := count + 1 ].

	space show.
	self waitPulses.
	self assert: count equals: 1.

	space close.
	self waitPulses.
	self assert: count equals: 1
]

{ #category : #running }
BlSpaceEventTest >> waitPulses [

	BlSpace pulseUntilEmptyTaskQueue: space timeout: 50 milliSeconds
]
