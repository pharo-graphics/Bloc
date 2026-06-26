Class {
	#name : #BlSpaceSimulator,
	#superclass : #Object,
	#instVars : [
		'space',
		'timeout'
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
	timeout := 500 milliSeconds
]

{ #category : #testing }
BlSpaceSimulator >> isOpened [
	^ space isOpened
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

	| finished |
	finished := false.
	space host
		wait: [ space universe hasDeferredActions or: [ space taskQueue isNotEmpty ] ]
		timeout: timeout
		onCompletion: [ finished := true ]
		onTimeout: [ finished := false ].
	^ finished
]

{ #category : #stepping }
BlSpaceSimulator >> pulseUntilSpaceOpenedAndEmptyTaskQueue [
	"Wait until the space is opened and doesn't have available tasks to execute."

	self isOpened ifFalse: [ self waitForSpaceOpened ].
	^ self pulseUntilEmptyTaskQueue
]
