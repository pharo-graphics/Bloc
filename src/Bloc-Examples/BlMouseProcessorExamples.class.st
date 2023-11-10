"
I contain examples-tests of mouse processor

"
Class {
	#name : #BlMouseProcessorExamples,
	#superclass : #BlEventProcessorExamplesTest,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'instance creation' }
BlMouseProcessorExamples >> middleMouseDownEvent [

	<sampleInstance>
	^ BlMouseDownEvent middle
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> middleMouseUpEvent [

	<sampleInstance>
	^ BlMouseUpEvent middle
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> primaryMouseDownEvent [

	<sampleInstance>
	^ BlMouseDownEvent primary
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> primaryMouseUpEvent [

	<sampleInstance>
	^ BlMouseUpEvent primary
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> secondaryMouseDownEvent [
	<gtExample>

	^ BlMouseDownEvent secondary
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> secondaryMouseUpEvent [
	<gtExample>

	^ BlMouseUpEvent secondary
]

{ #category : #'examples - sequence' }
BlMouseProcessorExamples >> testClick [

	<sampleInstance>
	| aMouseProcessor |
	aMouseProcessor := self testMouseProcessor.

	aMouseProcessor handleMouseDown: self primaryMouseDownEvent.
	aMouseProcessor handleMouseUp: self primaryMouseUpEvent.

	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> testMiddleDown [

	<sampleInstance>
	| aMouseProcessor anEvent |
	aMouseProcessor := self testMouseProcessor.
	anEvent := self middleMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton middle).

	^ aMouseProcessor
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> testMouseProcessor [

	<sampleInstance>
	| aMouseProcessor aSpace |
	aSpace := BlOSpace new.
	aMouseProcessor := BlMouseProcessor space: aSpace.

	self assert: aMouseProcessor space equals: aSpace.
	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> testPrimaryDown [

	<sampleInstance>
	| aMouseProcessor anEvent |
	aMouseProcessor := self testMouseProcessor.
	anEvent := self primaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton primary).

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> testPrimaryDownSecondaryDown [

	<sampleInstance>
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

{ #category : #examples }
BlMouseProcessorExamples >> testPrimaryDownSecondaryDownPrimaryUp [

	<sampleInstance>
	| aMouseProcessor anEvent |
	aMouseProcessor := self testPrimaryDownSecondaryDown.
	anEvent := self primaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> testPrimaryDownSecondaryDownPrimaryUpSecondaryUp [

	<sampleInstance>
	| aMouseProcessor anEvent |
	aMouseProcessor := self testPrimaryDownSecondaryDownPrimaryUp.
	anEvent := self secondaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> testSecondaryDown [

	<sampleInstance>
	| aMouseProcessor anEvent |
	aMouseProcessor := self testMouseProcessor.
	anEvent := self secondaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert:
		(aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor
]
