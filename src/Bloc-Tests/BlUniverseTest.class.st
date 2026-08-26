Class {
	#name : #BlUniverseTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #tests }
BlUniverseTest >> testErrorDuringPulseSignal [

	| aUniverse logger expectedError caughtError |
	aUniverse := BlUniverse new.
	expectedError := Error new messageText: 'Pulse test error'.
	aUniverse defer: [ expectedError signal ].
	logger := MemoryLogger new.
	logger runFor: BlUniversePulseErrorSignal during: [
		[ aUniverse pulse ] on: Error do: [ :err | caughtError := err ] ].

	self assert: caughtError equals: expectedError.
	self assert: (logger entries anySatisfy: [ :each | each error == expectedError ])
]

{ #category : #tests }
BlUniverseTest >> testEvaluateDeferred [

	| aUniverse evaluated |
	aUniverse := BlUniverse new.
	evaluated := false.
	aUniverse defer: [ evaluated := true ].
	self assert: aUniverse hasDeferredActions.
	self deny: aUniverse isSettled.

	aUniverse evaluateDeferred.
	self assert: evaluated.
	self deny: aUniverse hasDeferredActions.
	self assert: aUniverse isSettled
]

{ #category : #tests }
BlUniverseTest >> testSpaceOpenedSignal [

	| aSpace logger |
	aSpace := BlSpace new
		host: BlHeadlessHost new;
		yourself.
	logger := MemoryLogger new.
	[
		logger runFor: BlSpaceOpenedSignal during: [
			aSpace show.
			aSpace settle ].
		self assert: (logger entries anySatisfy: [ :each | each space == aSpace ])
	] ensure: [
		aSpace close.
		aSpace settle ]
]
