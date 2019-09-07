"
I contain examples of space related events
"
Class {
	#name : #BlSpaceEventExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Event'
}

{ #category : #'event handling' }
BlSpaceEventExamples >> ignoreSpaceEventsAfterCloseRequest [
	<gtExample>
	<noTest>
	| aSpace |

	aSpace := self space.
	aSpace eventRecorder: BlMemoryEventRecorder new.
	aSpace show.

	aSpace hostSpace enqueueEvent: (BlSpaceCloseRequest new timestamp: DateAndTime now).

	self assert: aSpace hasHostSpace not.

	^ aSpace
]

{ #category : #'instance creation' }
BlSpaceEventExamples >> space [
	<gtExample>
	
	^ BlSpace new host: BlHeadlessHost new
]

{ #category : #'show / close' }
BlSpaceEventExamples >> spaceClosed [
	<gtExample>
	<noTest>
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
BlSpaceEventExamples >> spaceDestroyed [
	<gtExample>
	<noTest>
	| aSpace events |
	events := OrderedCollection new.
	
	aSpace := self space.
	aSpace addEventHandlerOn: BlSpaceClosedEvent do: [ 
		events add: #closed ].
	aSpace addEventHandlerOn: BlSpaceDestroyedEvent do: [ 
		events add: #destroyed ].
	
	aSpace show.
	self assert: events size equals: 0.
	aSpace close.
	self assert: events size equals: 2.
	self assert: events asArray equals: #(closed destroyed).
	
	^ aSpace
]

{ #category : #'show / close' }
BlSpaceEventExamples >> spaceShown [
	<gtExample>
	<noTest>
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
