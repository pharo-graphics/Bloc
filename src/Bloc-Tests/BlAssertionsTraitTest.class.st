"
I test the assertion behavior provided by TBlDebug when assertions are enabled and disabled via Bloc enableAssertions / Bloc disableAssertions.
"
Class {
	#name : #BlAssertionsTraitTest,
	#superclass : #TestCase,
	#instVars : [
		'previousAssertionsEnabled',
		'assertionObject'
	],
	#category : #'Bloc-Tests'
}

{ #category : #running }
BlAssertionsTraitTest >> setUp [

	super setUp.
	previousAssertionsEnabled := Bloc assertionsEnabled.
	assertionObject := BlElement new
]

{ #category : #running }
BlAssertionsTraitTest >> tearDown [

	Bloc assertionsEnabled: previousAssertionsEnabled.
	super tearDown
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertDescriptionBlockNotEvaluatedWhenDisabled [

	| descriptionEvaluated |
	descriptionEvaluated := false.
	Bloc disableAssertions.
	assertionObject assert: [ false ] description: [
			descriptionEvaluated := true.
			'Should not be evaluated' ].
	self deny: descriptionEvaluated
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertDescriptionWhenDisabledDoesNotSignal [

	Bloc disableAssertions.
	self shouldnt: [ assertionObject assert: [ false ] description: 'Ignored description' ] raise: AssertionFailure
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertDescriptionWhenEnabledFailureSignals [

	Bloc enableAssertions.
	self
		should: [ assertionObject assert: [ false ] description: 'Custom error description' ]
		raise: AssertionFailure
		withExceptionDo: [ :anException | self assert: anException messageText equals: 'Custom error description' ]
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertDescriptionWhenEnabledSuccess [

	Bloc enableAssertions.
	self shouldnt: [ assertionObject assert: [ true ] description: 'Should not fail' ] raise: AssertionFailure
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertEqualsWhenDisabledDoesNotSignal [

	Bloc disableAssertions.
	self shouldnt: [ assertionObject assert: 10 equals: 20 ] raise: AssertionFailure
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertEqualsWhenEnabledFailureSignals [

	Bloc enableAssertions.
	self
		should: [ assertionObject assert: 10 equals: 20 ]
		raise: AssertionFailure
		withExceptionDo: [ :anException | self assert: anException messageText equals: 'Got 10 instead of 20.' ]
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertEqualsWhenEnabledSuccess [

	Bloc enableAssertions.
	self shouldnt: [ assertionObject assert: 42 equals: 42 ] raise: AssertionFailure
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertWhenDisabledDoesNotSignal [

	Bloc disableAssertions.
	self shouldnt: [ assertionObject assert: [ false ] ] raise: AssertionFailure
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertWhenEnabledFailureSignals [

	Bloc enableAssertions.
	self
		should: [ assertionObject assert: [ false ] ]
		raise: AssertionFailure
		withExceptionDo: [ :anException | self assert: anException messageText equals: 'Assertion failed' ]
]

{ #category : #tests }
BlAssertionsTraitTest >> testAssertWhenEnabledSuccess [

	Bloc enableAssertions.
	self shouldnt: [ assertionObject assert: [ true ] ] raise: AssertionFailure
]

{ #category : #tests }
BlAssertionsTraitTest >> testClassSideAssertWhenEnabledAndDisabled [

	Bloc enableAssertions.
	self
		should: [ BlElement assert: [ false ] description: 'Class assertion' ]
		raise: AssertionFailure
		withExceptionDo: [ :anException | self assert: anException messageText equals: 'Class assertion' ].

	Bloc disableAssertions.
	self shouldnt: [ BlElement assert: [ false ] description: 'Class assertion' ] raise: AssertionFailure
]
