"
I contain examples-tests of mouse processor

"
Class {
	#name : #BlMouseProcessorTest,
	#superclass : #TestCase,
	#instVars : [
		'mouseProcessor'
	],
	#category : #'Bloc-Tests-Events'
}

{ #category : #tests }
BlMouseProcessorTest >> createAndHandleMiddleMouseDown [

	| anEvent |
	anEvent := self middleMouseDownEvent.
	mouseProcessor handleMouseDown: anEvent
]

{ #category : #tests }
BlMouseProcessorTest >> createAndHandlePrimaryMouseDown [

	| anEvent |
	anEvent := self primaryMouseDownEvent.
	mouseProcessor handleMouseDown: anEvent
]

{ #category : #tests }
BlMouseProcessorTest >> createAndHandlePrimaryMouseUp [

	| anEvent |
	anEvent := self primaryMouseUpEvent.
	mouseProcessor handleMouseUp: anEvent
]

{ #category : #tests }
BlMouseProcessorTest >> createAndHandleSecondaryMouseDown [

	| anEvent |
	anEvent := self secondaryMouseDownEvent.
	mouseProcessor handleMouseDown: anEvent.
	
]

{ #category : #tests }
BlMouseProcessorTest >> createAndHandleSecondaryMouseUp [

	| anEvent |
	anEvent := self secondaryMouseUpEvent.
	mouseProcessor handleMouseUp: anEvent
]

{ #category : #'running - instance creation' }
BlMouseProcessorTest >> middleMouseDownEvent [

	^ BlMouseDownEvent middle
]

{ #category : #'running - instance creation' }
BlMouseProcessorTest >> middleMouseUpEvent [

	^ BlMouseUpEvent middle
]

{ #category : #'running - instance creation' }
BlMouseProcessorTest >> primaryMouseDownEvent [

	^ BlMouseDownEvent primary
]

{ #category : #'running - instance creation' }
BlMouseProcessorTest >> primaryMouseUpEvent [

	^ BlMouseUpEvent primary
]

{ #category : #'running - instance creation' }
BlMouseProcessorTest >> secondaryMouseDownEvent [

	^ BlMouseDownEvent secondary
]

{ #category : #'running - instance creation' }
BlMouseProcessorTest >> secondaryMouseUpEvent [

	^ BlMouseUpEvent secondary
]

{ #category : #running }
BlMouseProcessorTest >> setUp [

	super setUp.
	mouseProcessor := BlMouseProcessor space: BlSpace new
]

{ #category : #tests }
BlMouseProcessorTest >> testClick [

	self createAndHandlePrimaryMouseDown.
	self createAndHandlePrimaryMouseUp.
	self assert: mouseProcessor pressedButtons isEmpty.
]

{ #category : #tests }
BlMouseProcessorTest >> testMiddleDown [

	self createAndHandleMiddleMouseDown.
	self assert: mouseProcessor pressedButtons size equals: 1.
	self assert:
		(mouseProcessor pressedButtons includes: BlMouseButton middle)
]

{ #category : #tests }
BlMouseProcessorTest >> testMouseProcessorInitializedEmptyAndWithCorrectSpace [

	| aMouseProcessor aSpace |
	aSpace := BlSpace new.
	aMouseProcessor := BlMouseProcessor space: aSpace.

	self assert: aMouseProcessor space equals: aSpace.
	self assert: aMouseProcessor pressedButtons isEmpty
]

{ #category : #tests }
BlMouseProcessorTest >> testPrimaryDownCorrectlyHandled [

	self createAndHandlePrimaryMouseDown.
	
	self assert: mouseProcessor pressedButtons size equals: 1.
	self assert:
		(mouseProcessor pressedButtons includes: BlMouseButton primary)
]

{ #category : #tests }
BlMouseProcessorTest >> testPrimaryDownSecondaryDownCorrectlyHandled [

	self createAndHandlePrimaryMouseDown.
	self createAndHandleSecondaryMouseDown.
	
	self assert: mouseProcessor pressedButtons size equals: 2.
	self assert:
		(mouseProcessor pressedButtons includes: BlMouseButton primary).
	self assert:
		(mouseProcessor pressedButtons includes: BlMouseButton secondary).

]

{ #category : #tests }
BlMouseProcessorTest >> testPrimaryDownSecondaryDownPrimaryUpCorrectlyHandled [

	self createAndHandlePrimaryMouseDown.
	self createAndHandleSecondaryMouseDown.
	self createAndHandlePrimaryMouseUp.
	self assert: mouseProcessor pressedButtons size equals: 1.
	self assert:
		(mouseProcessor pressedButtons includes: BlMouseButton secondary)
]

{ #category : #tests }
BlMouseProcessorTest >> testPrimaryDownSecondaryDownPrimaryUpSecondaryUpCorrectlyHandled [

	self createAndHandlePrimaryMouseDown.
	self createAndHandleSecondaryMouseDown.
	self createAndHandlePrimaryMouseUp.
	self createAndHandleSecondaryMouseUp.
	
	self assert: mouseProcessor pressedButtons isEmpty
]

{ #category : #tests }
BlMouseProcessorTest >> testSecondaryDown [

	self createAndHandleSecondaryMouseDown.
	self assert: mouseProcessor pressedButtons size equals: 1.
	self assert:
		(mouseProcessor pressedButtons includes: BlMouseButton secondary)
]
