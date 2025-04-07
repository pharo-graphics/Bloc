Class {
	#name : #BlParameterizedHostTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testingSpaces',
		'hostClass'
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
	^ aSpace
]

{ #category : #running }
BlParameterizedHostTest >> setUp [
	super setUp.

	testingSpaces := OrderedCollection new.
]

{ #category : #running }
BlParameterizedHostTest >> tearDown [

	self waitTestingSpaces.
	testingSpaces do: [ :each | each close ].
	self waitTestingSpaces.
	
	super tearDown.

]

{ #category : #tests }
BlParameterizedHostTest >> waitTestingOpenedSpaces [

	testingSpaces do: [ :each |
		self assert: (BlSpace
			pulseUntilSpaceOpenedAndEmptyTaskQueue: each
			timeout: 200 milliSeconds) ]
]

{ #category : #tests }
BlParameterizedHostTest >> waitTestingSpaces [

	testingSpaces do: [ :each |
		self assert: (BlSpace
			pulseUntilEmptyTaskQueue: each
			timeout: 200 milliSeconds) ]
]
