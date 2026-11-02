Class {
	#name : #BlParallelUniverseTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #tests }
BlParallelUniverseTest >> testErrorDuringPulsePropagatesAndSignalsSemaphores [

	| aUniverse expectedError caughtError aSemaphore semaphoreSignaled |
	aUniverse := BlParallelUniverse host: BlHeadlessHost default.
	expectedError := Error new messageText: 'Pulse test error'.
	aUniverse defer: [ expectedError signal ].
	aSemaphore := Semaphore new.
	aUniverse registerPulseSemaphore: aSemaphore.
	[ aUniverse pulse ] on: Error do: [ :err | caughtError := err ].
	semaphoreSignaled := aSemaphore waitTimeoutMilliseconds: 50.
	self assert: caughtError equals: expectedError.
	self deny: semaphoreSignaled.
	self deny: aUniverse isPulsing
]

{ #category : #tests }
BlParallelUniverseTest >> testEvaluateDeferredActions [

	| aUniverse evaluated |
	aUniverse := BlParallelUniverse host: BlHeadlessHost default.
	evaluated := false.
	aUniverse defer: [ evaluated := true ].
	self assert: aUniverse hasDeferredActions.
	self deny: aUniverse isSettled.

	aUniverse evaluateDeferredActions.
	self assert: evaluated.
	self deny: aUniverse hasDeferredActions.
	self assert: aUniverse isSettled
]
