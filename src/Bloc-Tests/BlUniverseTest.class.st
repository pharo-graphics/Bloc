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
	self assert: (logger recordings anySatisfy: [ :each | each error == expectedError ])
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

	| aUniverse aSpace logger |
	aUniverse := BlUniverse new.
	aSpace := BlSpace new.
	logger := MemoryLogger new.
	logger runFor: BlSpaceOpenedSignal during: [
		aUniverse openSpace: aSpace ].

	self assert: (logger recordings anySatisfy: [ :each | each space == aSpace ])
]
