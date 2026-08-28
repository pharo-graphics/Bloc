"
I am an abstract base class for test cases that require a BlSpace fixture.
I provide automatic lifecycle management (opening in setUp and closing in tearDown), leak prevention in runCase, and convenience helper methods.
"
Class {
	#name : #BlSpaceTestCase,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'Bloc-Tests-Space'
}

{ #category : #accessing }
BlSpaceTestCase >> space [

	^ space
]

{ #category : #adding }
BlSpaceTestCase >> addChild: anElement [

	space root addChild: anElement.
	space settle.
	^ anElement
]

{ #category : #actions }
BlSpaceTestCase >> deferAndSettle: aBlock [

	space deferAndSettle: aBlock
]

{ #category : #running }
BlSpaceTestCase >> host [

	^ BlHeadlessHost default
]

{ #category : #running }
BlSpaceTestCase >> runCase [

	| initialSpaces |
	initialSpaces := self host universe spaces copy.
	^ [ super runCase ] ensure: [
			self host universe spaces copy
				reject: [ :each | initialSpaces includes: each ]
				thenDo: [ :each |
					[ each close; settle ] on: Exception do: [ ] ] ]
]

{ #category : #actions }
BlSpaceTestCase >> settle [

	space settle
]

{ #category : #running }
BlSpaceTestCase >> setUp [

	super setUp.
	space := BlSpace new.
	space host: self host.
	space show; settle
]

{ #category : #running }
BlSpaceTestCase >> tearDown [

	space ifNotNil: [
		[ space close; settle ] on: Exception do: [ ].
		space := nil ].
	super tearDown
]
