Class {
	#name : #BlFrameLayoutMulipleChildrenExamples,
	#superclass : #BlFrameLayoutChildrenExamples,
	#category : #'Bloc-Examples-Layout'
}

{ #category : #'examples - alignment' }
BlFrameLayoutMulipleChildrenExamples >> elementWithExactChildAlignLeftCenterAndExactChildCenter [
	<gtExample>
	| parent childOne childTwo |
	
	childOne := self childElementWithExactSize140per140.
	childTwo := self childElementWithExactSize100per50.
	childOne constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	childTwo constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	parent := self parentWithFrameLayoutAndFixedSize300per250.
	parent addChildren: {childOne . childTwo}.
	parent forceLayout.
	
	self assert: childOne position equals: 0@55.
	self assert: childOne extent equals: 140@140.
	self assert: childTwo position equals: 100@100.
	self assert: childTwo extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 300@250.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutMulipleChildrenExamples >> elementWithExactChildAlignTopLeftAndExactChildRightCenter [
	<gtExample>
	| parent childOne childTwo |
	
	childOne := self childElementWithExactSize140per140.
	childTwo := self childElementWithExactSize100per50.
	childTwo constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	parent := self parentWithFrameLayoutAndFixedSize300per250.
	parent addChildren: {childOne . childTwo}.
	parent forceLayout.
	
	self assert: childOne position equals: 0@0.
	self assert: childOne extent equals: 140@140.
	self assert: childTwo position equals: 200@100.
	self assert: childTwo extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 300@250.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutMulipleChildrenExamples >> elementWithNineExactChildrenWithAllAlignments [
	<gtExample>
	| parent childTopLeft childTopCenter childTopRight childCenterLeft childCenterCenter childCenterRight childBottomLeft childBottomCenter childBottomRight|
	
	childTopLeft := BlTextElement new 
		text: 'Top Left' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignLeft.
			c frame vertical alignTop ].
	childTopCenter := BlTextElement new 
		text: 'Top Center' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignTop ].
	childTopRight := BlTextElement new 
		text: 'Top Right' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignTop ].
		
	childCenterLeft := BlTextElement new 
		text: 'Center Left' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignLeft.
			c frame vertical alignCenter ].
	childCenterCenter := BlTextElement new 
		text: 'Center' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	childCenterRight := BlTextElement new 
		text: 'Center Right' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignCenter ].
		
	childBottomLeft := BlTextElement new 
		text: 'Botom Left' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignLeft.
			c frame vertical alignBottom ].
	childBottomCenter := BlTextElement new 
		text: 'Bottom Center' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignBottom ].
	childBottomRight := BlTextElement new 
		text: 'Bottom Right' asRopedText;
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignBottom ].
	
	parent := self parentWithFrameLayoutAndFixedSize300per250.
	parent addChildren: {
		childTopLeft . childTopCenter . childTopRight .
		childCenterLeft . childCenterCenter. childCenterRight.
		childBottomLeft . childBottomCenter. childBottomRight }.
	parent forceLayout.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 300@250.
	
	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutMulipleChildrenExamples >> elementWithTwoChildrenMatchingParentWithWeight [
	<gtExample>
	| parent childOne childTwo |
	
	childOne := self childElementMatchingParent.
	childTwo := self childElementMatchingParent.
	childOne border: (BlBorder builder paint: Color lightGray; width: 1; build).
	childOne constraintsDo: [ :c |
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	childTwo constraintsDo: [ :c |
		c frame horizontal weight: 0.5.
		c frame vertical weight: 0.9 ].
	parent := self parentWithFrameLayoutAndFixedSize300per250.
	parent addChildren: {childOne . childTwo}.
	parent forceLayout.
	
	self assert: childOne position equals: 0@0.
	self assert: childOne extent equals: 270@125.
	self assert: childTwo position equals: 0@0.
	self assert: childTwo extent equals: 150@225.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 300@250.
	
	^ parent
]

{ #category : #'examples - fit content' }
BlFrameLayoutMulipleChildrenExamples >> elementWithTwoExactChildrenAndFitContentParent [
	<gtExample>
	| parent childOne childTwo |
	
	childOne := self childElementWithVisualProperties.
	childTwo := self childElementWithVisualProperties.
	
	childOne constraintsDo: [ :c | 
		c vertical exact: 100.
		c horizontal exact: 250 ].
	childTwo constraintsDo: [ :c | 
		c vertical exact: 250.
		c horizontal exact: 100 ].
	
	parent := BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	parent addChildren: {childOne . childTwo}.
	parent forceLayout.
	
	self assert: childOne position equals: 0@0.
	self assert: childOne extent equals: 250@100.
	self assert: childTwo position equals: 0@0.
	self assert: childTwo extent equals: 100@250.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 250@250.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutMulipleChildrenExamples >> elementWithTwoExactChildrenAndNoAlignment [
	<gtExample>
	| parent childOne childTwo |
	
	childOne := self childElementWithExactSize140per140.
	childTwo := self childElementWithExactSize100per50.
	parent := self parentWithFrameLayoutAndFixedSize300per250.
	parent addChildren: {childOne . childTwo}.
	parent forceLayout.
	
	self assert: childOne position equals: 0@0.
	self assert: childOne extent equals: 140@140.
	self assert: childTwo position equals: 0@0.
	self assert: childTwo extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 300@250.
	
	^ parent
]
