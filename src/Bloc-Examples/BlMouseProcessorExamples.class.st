"
I contain examples-tests of mouse processor

"
Class {
	#name : #BlMouseProcessorExamples,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'running - instance creation' }
BlMouseProcessorExamples >> middleMouseDownEvent [

	^ BlMouseDownEvent middle
]

{ #category : #'running - instance creation' }
BlMouseProcessorExamples >> middleMouseUpEvent [

	^ BlMouseUpEvent middle
]

{ #category : #'running - instance creation' }
BlMouseProcessorExamples >> primaryMouseDownEvent [

	^ BlMouseDownEvent primary
]

{ #category : #'running - instance creation' }
BlMouseProcessorExamples >> primaryMouseUpEvent [

	^ BlMouseUpEvent primary
]

{ #category : #'running - instance creation' }
BlMouseProcessorExamples >> secondaryMouseDownEvent [

	^ BlMouseDownEvent secondary
]

{ #category : #'running - instance creation' }
BlMouseProcessorExamples >> secondaryMouseUpEvent [

	^ BlMouseUpEvent secondary
]

{ #category : #tests }
BlMouseProcessorExamples >> testClick [

	<sampleInstance>
	| aMouseProcessor |
	aMouseProcessor := self testMouseProcessor.

	aMouseProcessor handleMouseDown: self primaryMouseDownEvent.
	aMouseProcessor handleMouseUp: self primaryMouseUpEvent.

	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : #tests }
BlMouseProcessorExamples >> testMiddleDown [

	| aMouseProcessor anEvent |
	aMouseProcessor := self testMouseProcessor.
	anEvent := self middleMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton middle)
]

{ #category : #tests }
BlMouseProcessorExamples >> testMouseProcessor [

	| aMouseProcessor aSpace |
	aSpace := BlSpace new.
	aMouseProcessor := BlMouseProcessor space: aSpace.

	self assert: aMouseProcessor space equals: aSpace.
	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : #tests }
BlMouseProcessorExamples >> testPrimaryDown [

	| aMouseProcessor anEvent |
	aMouseProcessor := self testMouseProcessor.
	anEvent := self primaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton primary).

	^ aMouseProcessor
]

{ #category : #tests }
BlMouseProcessorExamples >> testPrimaryDownSecondaryDown [

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

{ #category : #tests }
BlMouseProcessorExamples >> testPrimaryDownSecondaryDownPrimaryUp [

	| aMouseProcessor anEvent |
	aMouseProcessor := self testPrimaryDownSecondaryDown.
	anEvent := self primaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor
]

{ #category : #tests }
BlMouseProcessorExamples >> testPrimaryDownSecondaryDownPrimaryUpSecondaryUp [

	| aMouseProcessor anEvent |
	aMouseProcessor := self testPrimaryDownSecondaryDownPrimaryUp.
	anEvent := self secondaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons isEmpty
]

{ #category : #tests }
BlMouseProcessorExamples >> testSecondaryDown [

	| aMouseProcessor anEvent |
	aMouseProcessor := self testMouseProcessor.
	anEvent := self secondaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton secondary)
]
