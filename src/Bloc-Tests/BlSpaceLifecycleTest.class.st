Class {
	#name : #BlSpaceLifecycleTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #tests }
BlSpaceLifecycleTest >> testCloseAlreadyClosedSpaceIsNoOp [

	| aSpace |
	aSpace := self newTestingSpace.
	self assert: aSpace isOpened.

	aSpace close.
	aSpace settle.
	self deny: aSpace isOpened.
	self deny: host isRunning.

	aSpace close.
	self deny: aSpace isOpened.
	self deny: host isRunning
]

{ #category : #tests }
BlSpaceLifecycleTest >> testCloseClearsPendingEvents [

	| aSpace |
	aSpace := self newTestingSpace.
	aSpace enqueueEvent: (BlMouseMoveEvent new position: 10 @ 10; yourself).
	self assert: aSpace hasEvents.

	aSpace close.
	aSpace settle.
	self deny: aSpace hasEvents
]

{ #category : #tests }
BlSpaceLifecycleTest >> testCloseFromPulseProcessClosesSpace [

	| aSpace |
	aSpace := self newTestingSpace.
	self assert: aSpace isOpened.
	self assert: host isRunning.

	aSpace deferAndSettle: [ aSpace close ].
	self deny: aSpace isOpened.
	self deny: host isRunning
]

{ #category : #tests }
BlSpaceLifecycleTest >> testCloseSpaceOnStoppedHostRunsOnPulseProcess [

	| aSpace closedProcess |
	aSpace := self newTestingSpace.
	aSpace addEventHandlerOn: BlSpaceClosedEvent doOnce: [
		closedProcess := Processor activeProcess ].
	self assert: aSpace isOpened.
	self assert: host isRunning.

	host stop.
	self deny: host isRunning.

	aSpace close.
	host settle.
	self deny: aSpace isOpened.
	self deny: closedProcess equals: Processor activeProcess.
	self assert: (closedProcess name beginsWith: 'Bloc Host Pulse Loop').
	self deny: host isRunning
]

{ #category : #tests }
BlSpaceLifecycleTest >> testCloseUnopenedSpaceDoesNotStartHost [

	| aSpace |
	aSpace := BlSpace new.
	aSpace host: host.
	self deny: aSpace isOpened.
	self deny: host isRunning.

	aSpace close.
	self deny: aSpace isOpened.
	self deny: host isRunning
]

{ #category : #tests }
BlSpaceLifecycleTest >> testHidingAnOpenSpaceHidesTheWindow [

	| aSpace |
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.
	aSpace show.
	aSpace settle.
	self assert: aSpace hostSpace isVisible.

	aSpace hide.
	self deny: aSpace hostSpace isVisible
]

{ #category : #tests }
BlSpaceLifecycleTest >> testHidingAndShowingAnOpenSpaceShowsTheWindow [

	| aSpace |
	Smalltalk vm operatingSystemName = 'unix' ifTrue: [ ^ self skip ].

	aSpace := self newTestingSpace.
	aSpace show.
	aSpace settle.
	self assert: aSpace hostSpace isVisible.

	aSpace hide.
	self deny: aSpace hostSpace isVisible.

	aSpace show.
	aSpace settle.
	self assert: aSpace hostSpace isVisible
]

{ #category : #tests }
BlSpaceLifecycleTest >> testHostCloseSpacesClosesAllAndStopsHost [

	| space1 space2 |
	space1 := self newTestingSpace.
	space2 := self newTestingSpace.
	self assert: (host spaces includes: space1).
	self assert: (host spaces includes: space2).
	self assert: host isRunning.

	host closeSpaces.
	host settle.
	self deny: space1 isOpened.
	self deny: space2 isOpened.
	self assert: host spaces isEmpty.
	self deny: host isRunning
]

{ #category : #tests }
BlSpaceLifecycleTest >> testHostSpaceOpenAndClose [

	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost default.
	self deny: aSpace hasHostSpace.

	aSpace hostSpaceOpen.
	self assert: aSpace hasHostSpace.
	self assert: aSpace hostSpace isValid.

	aSpace hostSpaceClose.
	self deny: aSpace hasHostSpace
]

{ #category : #tests }
BlSpaceLifecycleTest >> testImmediateCloseAfterShow [

	| aSpace |
	aSpace := BlSpace new.
	aSpace host: host.
	testingSpaces add: aSpace.
	aSpace show.
	aSpace close.
	aSpace settle.
	self deny: (aSpace host hasSpace: aSpace).
	self deny: aSpace isOpened
]

{ #category : #tests }
BlSpaceLifecycleTest >> testOpenAndClose [

	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost default.
	self deny: aSpace isOpened.

	aSpace open.
	aSpace settle.
	self assert: aSpace isOpened.

	aSpace close.
	aSpace settle.
	self deny: aSpace isOpened
]

{ #category : #tests }
BlSpaceLifecycleTest >> testShowAfterClose [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	aSpace root eventSimulator click.
	aSpace close.
	aSpace settle.
	aSpace show.
	aSpace settle.
	aSpace root eventSimulator click
]

{ #category : #tests }
BlSpaceLifecycleTest >> testShowAndClick [

	| aSpace |
	aSpace := self newTestingSpace.

	aSpace show.
	aSpace settle.
	aSpace root eventSimulator click
]

{ #category : #tests }
BlSpaceLifecycleTest >> testValidateHostSpaceDrawing [

	| aSpace |
	aSpace := BlSpace new.
	aSpace validateHostSpaceDrawing.
	self deny: aSpace isOpened.

	aSpace := self newTestingSpace.
	aSpace validateHostSpaceDrawing.
	self assert: aSpace isOpened
]
