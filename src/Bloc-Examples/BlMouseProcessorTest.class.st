"
I contain examples-tests of mouse processor

"
Class {
	#name : 'BlMouseProcessorTest',
	#superclass : 'TestCase',
	#category : 'Bloc-Examples-Event',
	#package : 'Bloc-Examples',
	#tag : 'Event'
}

{ #category : 'running - instance creation' }
BlMouseProcessorTest >> middleMouseDownEvent [

	^ BlMouseDownEvent middle
]

{ #category : 'running - instance creation' }
BlMouseProcessorTest >> middleMouseUpEvent [

	^ BlMouseUpEvent middle
]

{ #category : 'running - instance creation' }
BlMouseProcessorTest >> newMouseProcessor [

	^ BlMouseProcessor space: BlSpace new
]

{ #category : 'running - instance creation' }
BlMouseProcessorTest >> primaryMouseDownEvent [

	^ BlMouseDownEvent primary
]

{ #category : 'running - instance creation' }
BlMouseProcessorTest >> primaryMouseUpEvent [

	^ BlMouseUpEvent primary
]

{ #category : 'running - instance creation' }
BlMouseProcessorTest >> secondaryMouseDownEvent [

	^ BlMouseDownEvent secondary
]

{ #category : 'running - instance creation' }
BlMouseProcessorTest >> secondaryMouseUpEvent [

	^ BlMouseUpEvent secondary
]

{ #category : 'tests' }
BlMouseProcessorTest >> testClick [

	| aMouseProcessor |
	aMouseProcessor := self newMouseProcessor.

	aMouseProcessor handleMouseDown: self primaryMouseDownEvent.
	aMouseProcessor handleMouseUp: self primaryMouseUpEvent.

	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : 'tests' }
BlMouseProcessorTest >> testMiddleDown [

	| aMouseProcessor anEvent |
	aMouseProcessor := self newMouseProcessor.
	anEvent := self middleMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton middle)
]

{ #category : 'tests' }
BlMouseProcessorTest >> testMouseProcessorInitialState [

	| aMouseProcessor aSpace |
	aSpace := BlSpace new.
	aMouseProcessor := BlMouseProcessor space: aSpace.

	self assert: aMouseProcessor space equals: aSpace.
	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : 'tests' }
BlMouseProcessorTest >> testPrimaryDown [

	| aMouseProcessor anEvent |
	aMouseProcessor := self newMouseProcessor.
	anEvent := self primaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton primary).

	^ aMouseProcessor
]

{ #category : 'tests' }
BlMouseProcessorTest >> testPrimaryDownSecondaryDown [

	| aMouseProcessor anEvent |
	aMouseProcessor := self testPrimaryDown.
	anEvent := self secondaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 2.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton primary).
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor
]

{ #category : 'tests' }
BlMouseProcessorTest >> testPrimaryDownSecondaryDownPrimaryUp [

	| aMouseProcessor anEvent |
	aMouseProcessor := self testPrimaryDownSecondaryDown.
	anEvent := self primaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor
]

{ #category : 'tests' }
BlMouseProcessorTest >> testPrimaryDownSecondaryDownPrimaryUpSecondaryUp [

	| aMouseProcessor anEvent |
	aMouseProcessor := self testPrimaryDownSecondaryDownPrimaryUp.
	anEvent := self secondaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons isEmpty
]

{ #category : 'tests' }
BlMouseProcessorTest >> testSecondaryDown [

	| aMouseProcessor anEvent |
	aMouseProcessor := self newMouseProcessor.
	anEvent := self secondaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton secondary)
]
