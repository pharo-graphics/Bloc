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
	aSpace host: hostClass new.
	testingSpaces add: aSpace.
	aSpace show.
	^ aSpace
]

{ #category : #running }
BlParameterizedHostTest >> runCase [

	^ BlPulseLoopRequired value: false during: [ super runCase ]
]

{ #category : #running }
BlParameterizedHostTest >> setUp [
	super setUp.

	testingSpaces := OrderedCollection new.
	initialSpaces := hostClass default universe spaces copy.
]

{ #category : #running }
BlParameterizedHostTest >> tearDown [

	testingSpaces do: [ :each | each close ].
	self waitTestingSpaces.

	(hostClass default universe spaces copy reject: [ :each | initialSpaces includes: each ])
		do: [ :each | each close ].
	self waitTestingSpaces.

	super tearDown
]

{ #category : #tests }
BlParameterizedHostTest >> waitTestingSpaces [

	testingSpaces do: [ :each | each waitPendingWork ]
]
