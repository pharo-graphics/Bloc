Class {
	#name : #BlParallelUniverseTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #tests }
BlParallelUniverseTest >> testSnapshotAndQuit [

	| aSpace universe |
	aSpace := BlSpace new
		host: BlHeadlessHost default;
		yourself.
	universe := aSpace host universe.
	[
		universe snapshot: false andQuit: false.
		self assert: universe hasDeferredActions.
		self deny: universe isSettled.

		aSpace settle.
		self deny: universe hasDeferredActions.
		self assert: universe isSettled
	] ensure: [
		aSpace close.
		aSpace settle ]
]

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
BlParallelUniverseTest >> testEvaluateDeferred [

	| aUniverse evaluated |
	aUniverse := BlParallelUniverse new.
	evaluated := false.
	aUniverse defer: [ evaluated := true ].
	self assert: aUniverse hasDeferredActions.
	self deny: aUniverse isSettled.

	aUniverse evaluateDeferred.
	self assert: evaluated.
	self deny: aUniverse hasDeferredActions.
	self assert: aUniverse isSettled
]
