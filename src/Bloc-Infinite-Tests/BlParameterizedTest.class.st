Class {
	#name : #BlParameterizedTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'testingSpaces',
		'hostClass'
	],
	#category : #'Bloc-Infinite-Tests'
}

{ #category : #testing }
BlParameterizedTest class >> isAbstract [

	^ self == BlParameterizedTest
]

{ #category : #tests }
BlParameterizedTest class >> testParameters [

	^ ParametrizedTestMatrix new
		forSelector: #hostClass
		addOptions: {
			BlOSWindowSDL2Host.
		   BlMockedHost.
			BlMorphicWindowHost }
]

{ #category : #accessing }
BlParameterizedTest >> hostClass [

	^ hostClass
]

{ #category : #accessing }
BlParameterizedTest >> hostClass: aClass [

	hostClass := aClass
]

{ #category : #'instance creation' }
BlParameterizedTest >> newTestingSpace [

	| aSpace |
	aSpace := BlSpace new.
	aSpace host: hostClass new.
	testingSpaces add: aSpace.
	^ aSpace
]

{ #category : #running }
BlParameterizedTest >> setUp [
	super setUp.

	testingSpaces := OrderedCollection new.
]

{ #category : #running }
BlParameterizedTest >> tearDown [

	self waitTestingSpaces.
	testingSpaces do: [ :each | each close ].
	self waitTestingSpaces.
	
	super tearDown.

]

{ #category : #tests }
BlParameterizedTest >> waitTestingSpaces [

	testingSpaces do: [ :each |
		self assert: (BlSpace
			pulseUntilEmptyTaskQueue: each
			timeout: 200 milliSeconds) ]
]
