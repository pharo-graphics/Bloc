Class {
	#name : #BlKeyboardProcessorTest,
	#superclass : #TestCase,
	#instVars : [
		'processor',
		'space'
	],
	#category : #'Bloc-Tests-Universe'
}

{ #category : #initialization }
BlKeyboardProcessorTest >> setUp [

	super setUp.
	
	space := BlSpace new.
	processor := BlKeyboardProcessor new.
	processor space: space
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
	self assert: processor keystrokesAllowed.
	self assert: (processor buffer hasEvent: KeyboardKey A)
]
