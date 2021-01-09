Class {
	#name : #BlFrameLayoutChildrenExamples,
	#superclass : #BlFrameLayoutExamples,
	#category : #'Bloc-Layout-Examples-Frame'
}

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
	self assertExactConstraint: 100@50 forElement: element.
	
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutChildrenExamples >> parentWithFrameLayoutAndFixedSize [
	<gtExample>
	| element |
	element :=  self parentWithFixedSize.
	element
		layout: BlFrameLayout new.
	
	self assert: element layout class equals: BlFrameLayout.
	
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
