Class {
	#name : #BlFrameLayoutChildrenExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Layout'
}

{ #category : #'examples - setup' }
BlFrameLayoutChildrenExamples >> childElementMatchingParent [
	<gtExample>
	| element |
	element := self childElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutChildrenExamples >> childElementWithExactSize100per50 [
	<gtExample>
	| element |
	element :=  self childElementWithVisualProperties.
	element constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical exact: 50 ].
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer size equals: 100.
	self assert: element constraints vertical resizer size equals: 50.
	
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutChildrenExamples >> childElementWithExactSize140per140 [
	<gtExample>
	| element |
	element :=  self childElementWithVisualProperties.
	element constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140 ].
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer size equals: 140.
	self assert: element constraints vertical resizer size equals: 140.
	
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutChildrenExamples >> childElementWithVisualProperties [
	<gtExample>
	| element |
	element :=  BlElement new
		background: Color cyan;
		border: (BlBorder builder paint: Color blue; width: 1; build);
		yourself.
	
	self assert: element border width equals: 1.
	self assert: element border paint equals: Color blue asBlPaint.
	self assert: element background equals: Color cyan asBlBackground.
		
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutChildrenExamples >> parentWithFrameLayoutAndFixedSize [
	<gtExample>
	| element |
	element :=  BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		size: 400@300;
		yourself.
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer size equals: 400.
	self assert: element constraints vertical resizer size equals: 300.
	self assert: element layout class equals: BlFrameLayout.
	self assert: element border width equals: 3.
	self assert: element border paint equals: Color red asBlPaint.
	
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutChildrenExamples >> parentWithFrameLayoutAndFixedSize300per250 [
	<gtExample>
	| element |
	element :=  BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		size: 300@250;
		yourself.
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer size equals: 300.
	self assert: element constraints vertical resizer size equals: 250.
	self assert: element layout class equals: BlFrameLayout.
	self assert: element border width equals: 3.
	self assert: element border paint equals: Color red asBlPaint.
	
	^ element
]
