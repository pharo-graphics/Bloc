Class {
	#name : #BlSpaceSimulator,
	#superclass : #Object,
	#instVars : [
		'space',
		'timeout',
		'deadline',
		'uiProcess'
	],
	#category : #'Bloc-Simulation'
}

{ #category : #'instance creation' }
BlSpaceSimulator class >> forSpace: aSpace [
	^ self new
		space: aSpace;
		yourself
]

{ #category : #accessing }
BlSpaceSimulator class >> defaultTimeout [
	^ 500 milliSeconds
]

{ #category : #accessing }
BlSpaceSimulator >> space: aSpace [
	space := aSpace
]

{ #category : #accessing }
BlSpaceSimulator >> timeout [
	^ timeout
]

{ #category : #accessing }
BlSpaceSimulator >> timeout: aDuration [
	timeout := aDuration
]

{ #category : #initialization }
BlSpaceSimulator >> initialize [
	super initialize.
	timeout := self class defaultTimeout
]

{ #category : #testing }
BlSpaceSimulator >> isOpened [
	^ space isOpened
]

{ #category : #testing }
BlSpaceSimulator >> hasUIProcess [
	space host uiProcessDo: [ :uiProc | uiProcess := uiProc ].
	^ uiProcess isNotNil and: [ uiProcess ~= Processor activeProcess ]
]

{ #category : #private }
BlSpaceSimulator >> waitLoopCondition [
	^ space universe hasDeferredActions or: [ 
		(space taskQueue isEmpty or: [ 
			space time now >= deadline ]) not ]
]

{ #category : #private }
BlSpaceSimulator >> waitForConcurrentUIProcess [
	[ self waitLoopCondition ]
		whileTrue: [ (Delay forMilliseconds: 5) wait ]
]

{ #category : #private }
BlSpaceSimulator >> pulseManually [
	space time
		every: 5 milliSeconds
		while: [ self waitLoopCondition ]
		do: [
			space host runOneCycle. 
			space universe pulse ].
	space universe pulse.
]

{ #category : #private }
BlSpaceSimulator >> waitForSpaceOpened [
	| aSemaphore |
	aSemaphore := Semaphore new.
	space
		addEventHandlerOn: BlSpaceShownEvent
		doOnce: [ :event | aSemaphore signal ].
	aSemaphore waitTimeoutMilliseconds: timeout asMilliSeconds
]

{ #category : #stepping }
BlSpaceSimulator >> pulseUntilEmptyTaskQueue [
	"Wait until the space doesn't have available tasks to execute."

	deadline := space time now + timeout.
	self hasUIProcess
		ifTrue: [ self waitForConcurrentUIProcess ]
		ifFalse: [ self pulseManually ].

	^ space taskQueue isEmpty
]

{ #category : #stepping }
BlSpaceSimulator >> pulseUntilSpaceOpenedAndEmptyTaskQueue [
	"Wait until the space is opened and doesn't have available tasks to execute."

	self isOpened ifFalse: [ self waitForSpaceOpened ].
	^ self pulseUntilEmptyTaskQueue
]
