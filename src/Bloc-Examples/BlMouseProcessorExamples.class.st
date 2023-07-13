"
I contain examples-tests of mouse processor

"
Class {
	#name : #BlMouseProcessorExamples,
	#superclass : #BlEventProcessorExamples,
	#category : #'Bloc-Examples-Event'
}

{ #category : #'examples - sequence' }
BlMouseProcessorExamples >> click [
	<gtExample>
	| aMouseProcessor |
	
	aMouseProcessor := self mouseProcessor.

	aMouseProcessor handleMouseDown: self primaryMouseDownEvent.
	aMouseProcessor handleMouseUp: self primaryMouseUpEvent.

	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> middleDown [
	<gtExample>
	| aMouseProcessor anEvent |
	
	aMouseProcessor := self mouseProcessor.
	anEvent := self middleMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton middle).

	^ aMouseProcessor
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> middleMouseDownEvent [
	<gtExample>

	^ BlMouseDownEvent middle
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> middleMouseUpEvent [
	<gtExample>

	^ BlMouseUpEvent middle
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> mouseProcessor [
	| aMouseProcessor aSpace |
	<gtExample>
	
	aSpace := BlOSpace new.
	aMouseProcessor := BlMouseProcessor space: aSpace.
	
	self assert: aMouseProcessor space equals: aSpace.
	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> primaryDown [
	<gtExample>
	| aMouseProcessor anEvent |
	
	aMouseProcessor := self mouseProcessor.
	anEvent := self primaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton primary).

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> primaryDownSecondaryDown [
	<gtExample>
	| aMouseProcessor anEvent |

	aMouseProcessor := self primaryDown.
	anEvent := self secondaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 2.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton primary).
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> primaryDownSecondaryDownPrimaryUp [
	<gtExample>
	| aMouseProcessor anEvent |

	aMouseProcessor := self primaryDownSecondaryDown.
	anEvent := self primaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor
]

{ #category : #examples }
BlMouseProcessorExamples >> primaryDownSecondaryDownPrimaryUpSecondaryUp [
	<gtExample>
	| aMouseProcessor anEvent |

	aMouseProcessor := self primaryDownSecondaryDownPrimaryUp.
	anEvent := self secondaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> primaryMouseDownEvent [
	<gtExample>

	^ BlMouseDownEvent primary
]

{ #category : #'instance creation' }
BlMouseProcessorExamples >> primaryMouseUpEvent [
	<gtExample>

	^ BlMouseUpEvent primary
]

{ #category : #examples }
BlMouseProcessorExamples >> secondaryDown [
	<gtExample>
	| aMouseProcessor anEvent |
	
	aMouseProcessor := self mouseProcessor.
	anEvent := self secondaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor
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
