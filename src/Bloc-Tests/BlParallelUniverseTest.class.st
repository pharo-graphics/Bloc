Class {
	#name : #BlParallelUniverseTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #tests }
BlParallelUniverseTest >> testErrorDuringPulseSignal [

	| aUniverse logger expectedError caughtError |
	aUniverse := BlParallelUniverse new.
	expectedError := Error new messageText: 'Pulse test error'.
	aUniverse defer: [ expectedError signal ].
	logger := MemoryLogger new.
	logger runFor: BlParallelUniverseErrorDuringPulseSignal during: [
		[ aUniverse pulse ] on: Error do: [ :err | caughtError := err ] ].
	self assert: caughtError equals: expectedError.
	self assert: (logger entries anySatisfy: [ :each | each signaledError == expectedError ])
]

{ #category : #tests }
BlParallelUniverseTest >> testEvaluateDeferredActions [

	| aUniverse evaluated |
	aUniverse := BlParallelUniverse new.
	evaluated := false.
	aUniverse defer: [ evaluated := true ].
	self assert: aUniverse hasDeferredActions.
	self deny: aUniverse isSettled.

	aUniverse evaluateDeferredActions.
	self assert: evaluated.
	self deny: aUniverse hasDeferredActions.
	self assert: aUniverse isSettled
]
