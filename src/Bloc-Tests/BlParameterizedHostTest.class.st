Class {
	#name : #BlParameterizedHostTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testingSpaces',
		'hostClass',
		'initialSpaces'
	],
	#category : #'Bloc-Tests'
}

{ #category : #private }
BlParameterizedHostTest class >> isAbstract [

	^ self == BlParameterizedHostTest
]

{ #category : #'building suites' }
BlParameterizedHostTest class >> testParameters [

	^ ParametrizedTestMatrix new
		forSelector: #hostClass
		addOptions: BlHost supportedHostClasses
]

{ #category : #accessing }
BlParameterizedHostTest >> hostClass [

	^ hostClass
]

{ #category : #accessing }
BlParameterizedHostTest >> hostClass: aClass [

	hostClass := aClass
]

{ #category : #'instance creation' }
BlParameterizedHostTest >> newTestingSpace [

	| aSpace |
	aSpace := BlSpace new.
	aSpace
		host: hostClass default;
		show;
		settle.

	testingSpaces add: aSpace.

	^ aSpace
]

{ #category : #running }
BlParameterizedHostTest >> runCase [

	^ super runCase
]

{ #category : #running }
BlParameterizedHostTest >> setUp [
	super setUp.

	testingSpaces := OrderedCollection new.
	initialSpaces := hostClass default universe spaces copy.
]

{ #category : #running }
BlParameterizedHostTest >> tearDown [

	testingSpaces do: [ :each |
			[
				each
					close;
					settle ]
				on: Exception
				do: [ ] ].

	hostClass ifNotNil: [
			hostClass default universe spaces copy reject: [ :each | initialSpaces includes: each ] thenDo: [ :each |
					[
						each close.
						each settle ]
						on: Exception
						do: [ ] ] ].

	super tearDown
]

{ #category : #tests }
BlParameterizedHostTest >> waitTestingSpaces [

	self
		deprecated: 'Settle the relevant space directly using #settle'
		transformWith: '`@receiver waitTestingSpaces' -> '`@receiver testingSpaces do: [ :each | each settle ]'.

	testingSpaces do: [ :each | each settle ]
]
