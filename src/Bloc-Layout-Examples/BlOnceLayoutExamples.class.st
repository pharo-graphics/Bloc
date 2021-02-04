Class {
	#name : #BlOnceLayoutExamples,
	#superclass : #Object,
	#traits : 'TBlLayoutExamplesSetup',
	#classTraits : 'TBlLayoutExamplesSetup classTrait',
	#category : #'Bloc-Layout-Examples-Once'
}

{ #category : #examples }
BlOnceLayoutExamples >> onceLinearLayoutExact [
	<gtExample>
	| aContainer aChildA aChildB aChildC |
	
	aContainer := self parentWithFixedSize.
	aContainer layout: (BlOnceLayout on: (BlLinearLayout vertical cellSpacing: 10)).
	
	aChildA := self childExact: 150@80.
	aChildB := self childExact: 250@80.
	aChildC := self childExact: 200@80.
	
	aContainer addChildren: { aChildA . aChildB . aChildC }.
	
	aContainer forceLayout.

	self assert: aContainer layout isStopped.
	self assert: aContainer bounds asRectangle equals: (0@0 extent: 400@300).

	self assert: aChildA bounds asRectangle equals: (0@10 extent: 150@80).
	self assert: aChildB bounds asRectangle equals: (0@100 extent: 250@80).
	self assert: aChildC bounds asRectangle equals: (0@190 extent: 200@80).

	self assert: aChildA constraints position equals: 0@10.
	self assert: aChildB constraints position equals: (0@100).
	self assert: aChildC constraints position equals: (0@190).

	self assert: aChildA constraints horizontal resizer equals: (BlLayoutResizer exact: 150).
	self assert: aChildA constraints vertical resizer equals: (BlLayoutResizer exact: 80).
	self assert: aChildB constraints horizontal resizer equals: (BlLayoutResizer exact: 250).
	self assert: aChildB constraints vertical resizer equals: (BlLayoutResizer exact: 80).
	self assert: aChildC constraints horizontal resizer equals: (BlLayoutResizer exact: 200).
	self assert: aChildC constraints vertical resizer equals: (BlLayoutResizer exact: 80).

	^ aContainer
]

{ #category : #examples }
BlOnceLayoutExamples >> onceLinearLayoutMatchParent [
	<gtExample>
	| aContainer aChildA aChildB aChildC |
	
	aContainer := self parentWithFixedSize.
	aContainer layout: (BlOnceLayout on: (BlLinearLayout vertical cellSpacing: 15)).
	
	aChildA := self childElementMatchingParent.
	aChildB := self childElementMatchingParent.
	aChildC := self childElementMatchingParent.
	
	aContainer addChildren: { aChildA . aChildB . aChildC }.
	
	aContainer forceLayout.
	
	self assert: aContainer layout isStopped.
	self assert: aContainer bounds asRectangle equals: (0@0 extent: 400@300).

	self assert: aChildA bounds asRectangle equals: (0@15 extent: 400@80).
	self assert: aChildB bounds asRectangle equals: (0@110 extent: 400@80).
	self assert: aChildC bounds asRectangle equals: (0@205 extent: 400@80).

	self assert: aChildA constraints position equals: 0@15.
	self assert: aChildB constraints position equals: (0@110).
	self assert: aChildC constraints position equals: (0@205).

	self assert: aChildA constraints horizontal resizer equals: (BlLayoutResizer exact: 400).
	self assert: aChildA constraints vertical resizer equals: (BlLayoutResizer exact: 80).
	self assert: aChildB constraints horizontal resizer equals: (BlLayoutResizer exact: 400).
	self assert: aChildB constraints vertical resizer equals: (BlLayoutResizer exact: 80).
	self assert: aChildC constraints horizontal resizer equals: (BlLayoutResizer exact: 400).
	self assert: aChildC constraints vertical resizer equals: (BlLayoutResizer exact: 80).
	
	^ aContainer
]
