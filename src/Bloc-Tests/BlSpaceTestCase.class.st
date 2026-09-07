"
I am an abstract base class for test cases that require a BlSpace fixture.
I provide automatic lifecycle management (opening in setUp and closing in tearDown) and leak prevention in runCase.
"
Class {
	#name : #BlSpaceTestCase,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Tests-Space'
}

{ #category : #testing }
BlSpaceTestCase class >> isAbstract [

	^ self == BlSpaceTestCase
]

{ #category : #accessing }
BlSpaceTestCase >> host [

	^ BlHeadlessHost default
]

{ #category : #'instance creation' }
BlSpaceTestCase >> newSpace [

	^ BlSpace new
]

{ #category : #running }
BlSpaceTestCase >> runCase [

	| initialSpaces |
	initialSpaces := self host spaces copy.
	^ [ super runCase ] ensure: [
			self host spaces copy
				reject: [ :each | initialSpaces includes: each ]
				thenDo: [ :each |
					[ each close; settle ] on: Exception do: [ ] ] ]
]

{ #category : #running }
BlSpaceTestCase >> setUp [

	super setUp.
	space := self newSpace.
	space host: self host.
	space show; settle
]

{ #category : #accessing }
BlSpaceTestCase >> space [

	^ space
]

{ #category : #running }
BlSpaceTestCase >> tearDown [

	space ifNotNil: [
		[ space close; settle ] on: Exception do: [ ].
		space := nil ].
	super tearDown
]
