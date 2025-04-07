Class {
	#name : #BlKeyboardProcessorTest,
	#superclass : #TestCase,
	#instVars : [
		'processor',
		'space'
	],
	#category : #'Bloc-Tests-Universe'
}

{ #category : #running }
BlKeyboardProcessorTest >> setUp [

	super setUp.
	
	space := BlSpace new.
	processor := BlKeyboardProcessor space: space
]

{ #category : #running }
BlKeyboardProcessorTest >> tearDown [

	super tearDown.

	processor := nil.
	space := nil
]

{ #category : #tests }
BlKeyboardProcessorTest >> testProcessKeyDown [

	| eventA |
	eventA := BlKeyDownEvent new.
	eventA key: KeyboardKey A.

	processor processKeyDown: eventA.
	self assert: processor areKeystrokesAllowed.
	self assert: (processor buffer hasEvent: KeyboardKey A)
]
