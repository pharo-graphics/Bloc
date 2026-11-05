"
I test the assertion behavior provided by TBlDebug when assertions are enabled and disabled via Bloc enableAssertions / Bloc disableAssertions.
"
Class {
	#name : #TBlDebugTest,
	#superclass : #TestCase,
	#instVars : [
		'previousAssertionsEnabled',
		'assertionObject'
	],
	#category : #'Bloc-Tests'
}

{ #category : #running }
TBlDebugTest >> setUp [

	super setUp.
	previousAssertionsEnabled := Bloc assertionsEnabled.
	assertionObject := BlElement new
]

{ #category : #running }
TBlDebugTest >> tearDown [

	Bloc assertionsEnabled: previousAssertionsEnabled.
	super tearDown
]

{ #category : #tests }
TBlDebugTest >> testAssertDescriptionBlockNotEvaluatedWhenDisabled [

	| descriptionEvaluated |
	descriptionEvaluated := false.
	Bloc disableAssertions.
	assertionObject assert: [ false ] description: [
			descriptionEvaluated := true.
			'Should not be evaluated' ].
	self deny: descriptionEvaluated
]

{ #category : #tests }
TBlDebugTest >> testAssertDescriptionWhenDisabledDoesNotSignal [

	Bloc disableAssertions.
	self shouldnt: [ assertionObject assert: [ false ] description: 'Ignored description' ] raise: AssertionFailure
]

{ #category : #tests }
TBlDebugTest >> testAssertDescriptionWhenEnabledFailureSignals [

	Bloc enableAssertions.
	self
		should: [ assertionObject assert: [ false ] description: 'Custom error description' ]
		raise: AssertionFailure
		withExceptionDo: [ :anException | self assert: anException messageText equals: 'Custom error description' ]
]

{ #category : #tests }
TBlDebugTest >> testAssertDescriptionWhenEnabledSuccess [

	Bloc enableAssertions.
	self shouldnt: [ assertionObject assert: [ true ] description: 'Should not fail' ] raise: AssertionFailure
]

{ #category : #tests }
TBlDebugTest >> testAssertEqualsWhenDisabledDoesNotSignal [

	Bloc disableAssertions.
	self shouldnt: [ assertionObject assert: 10 equals: 20 ] raise: AssertionFailure
]

{ #category : #tests }
TBlDebugTest >> testAssertEqualsWhenEnabledFailureSignals [

	Bloc enableAssertions.
	self
		should: [ assertionObject assert: 10 equals: 20 ]
		raise: AssertionFailure
		withExceptionDo: [ :anException | self assert: anException messageText equals: 'Got 10 instead of 20.' ]
]

{ #category : #tests }
TBlDebugTest >> testAssertEqualsWhenEnabledSuccess [

	Bloc enableAssertions.
	self shouldnt: [ assertionObject assert: 42 equals: 42 ] raise: AssertionFailure
]

{ #category : #tests }
TBlDebugTest >> testAssertWhenDisabledDoesNotSignal [

	Bloc disableAssertions.
	self shouldnt: [ assertionObject assert: [ false ] ] raise: AssertionFailure
]

{ #category : #tests }
TBlDebugTest >> testAssertWhenEnabledFailureSignals [

	Bloc enableAssertions.
	self
		should: [ assertionObject assert: [ false ] ]
		raise: AssertionFailure
		withExceptionDo: [ :anException | self assert: anException messageText equals: 'Assertion failed' ]
]

{ #category : #tests }
TBlDebugTest >> testAssertWhenEnabledSuccess [

	Bloc enableAssertions.
	self shouldnt: [ assertionObject assert: [ true ] ] raise: AssertionFailure
]

{ #category : #tests }
TBlDebugTest >> testClassSideAssertWhenEnabledAndDisabled [

	Bloc enableAssertions.
	self
		should: [ BlElement assert: [ false ] description: 'Class assertion' ]
		raise: AssertionFailure
		withExceptionDo: [ :anException | self assert: anException messageText equals: 'Class assertion' ].

	Bloc disableAssertions.
	self shouldnt: [ BlElement assert: [ false ] description: 'Class assertion' ] raise: AssertionFailure
]
