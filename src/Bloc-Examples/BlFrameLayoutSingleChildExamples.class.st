"
I contain examples of positioning a single element within a parent element that uses a ${class:BlFrameLayout}$.
"
Class {
	#name : #BlFrameLayoutSingleChildExamples,
	#superclass : #BlFrameLayoutChildrenExamples,
	#category : #'Bloc-Examples-Layout'
}

{ #category : #'examples - setup' }
BlFrameLayoutSingleChildExamples >> childElementMatchingParentWith25per50Percent [
	<gtExample>
	| element |
	element := self childElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.25.
		c frame vertical weight: 0.5 ].
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	self assert: element constraints frame horizontal weight equals: 0.25.
	self assert: element constraints frame vertical weight equals: 0.5.
	
	^ element
]

{ #category : #'examples - setup' }
BlFrameLayoutSingleChildExamples >> childElementMatchingParentWith50per40Percent [
	<gtExample>
	| element |
	element := self childElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.5.
		c frame vertical weight: 0.4 ].
	
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	self assert: element constraints frame horizontal weight equals: 0.5.
	self assert: element constraints frame vertical weight equals: 0.4.
		
	^ element
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementDocumentationWithOneExactChildAlignBottomRightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140.
		c frame horizontal alignRight.
		c frame vertical alignBottom ].

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent size: 300@300.
	parent addChild: child.
	
	parent forceLayout.
	self assert: child position equals: 160@160.
	self assert: child extent equals: 140@140.
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 300@300.
	
	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementForDocumentationWithOneChildMatchExactParentWithWeight [
	<gtExample>
	| parent child |
	
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent.
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.
	parent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 360@150.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - matching parent' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParent [
	<gtExample>
	| child aParent |
	child := self childElementMatchingParent.
	aParent := self parentWithFrameLayoutAndFixedSize.
	
	aParent addChild: child.
	aParent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 400@300.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'examples - matching parent' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithPadding [
	<gtExample>
	| aChild aParent |
	
	aChild := self childElementWithVisualProperties.
	aChild constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	aParent := self parentWithFrameLayoutAndFixedSize.

	aParent constraints 
		padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	aParent addChild: aChild.
	aParent forceLayout.

	self assert: aChild position equals: 40@10.
	self assert: aChild extent equals: 340@260.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'examples - matching parent' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithPaddingAndMargin [
	<gtExample>
	| aChild aParent |
	
	aChild := self childElementWithVisualProperties.
	aChild constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	aChild margin: (BlInsets top: 40 right: 30 bottom: 20 left: 10).
	
	aParent := self parentWithFrameLayoutAndFixedSize.
	aParent padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	aParent addChild: aChild.
	
	aParent forceLayout.

	self assert: aChild position equals: 50@50.
	self assert: aChild extent equals: 300@200.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 400@300.
	
	^ aParent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithWeight [
	<gtExample>
	| parent child |
	
	child := self childElementMatchingParentWith50per40Percent.
	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.
	parent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 200@120.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithWeightAndPadding [
	<gtExample>
	| child parent |
	
	child := self childElementMatchingParentWith25per50Percent.
	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@10.
	self assert: child extent equals: 85@130.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildMatchExactParentWithWeightAndPaddingAndMargin [
	<gtExample>
	| child parent |
	
	child := self childElementMatchingParentWith25per50Percent.
	child margin: (BlInsets top: 40 right: 30 bottom: 20 left: 10).
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.
	
	parent forceLayout.

	self assert: child position equals: 50@50.
	self assert: child extent equals: 75@100.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - weight' }
BlFrameLayoutSingleChildExamples >> elementWithOneChildWithExactSizeParentWithWeight [
	<gtExample>
	| parent child |
	
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c |
		c horizontal exact: 140.
		c vertical exact: 140.
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5 ].
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.
	parent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 140@140.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomCenterAndWithWeightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraintsDo: [ :c |
		c frame horizontal weight: 0.9.
		c frame vertical weight: 0.5.
		c frame horizontal alignCenter.
		c frame vertical alignBottom.  ].

	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomCenterInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomCenterInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignBottom.
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent 
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomLeftInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
.
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomLeftInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignBottom.
	
	parent :=  self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomRightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@250.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignBottomRightInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignBottom.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@220.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 150@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignCenter.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterLeftInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterLeftInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignCenter.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterRightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@125.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignCenterRightInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignCenter.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@115.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignLeftInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.

	parent := self parentWithFrameLayoutAndFixedSize.		
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignRightInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@10.
	self assert: child extent equals: 100@50.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopCenterInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.
	parent forceLayout.

	self assert: child position equals: 150@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopCenterInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignCenter.
	child constraints frame vertical alignTop.
	
	parent := self parentWithFrameLayoutAndFixedSize.	
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 160@10.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopLeftInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.

	parent := self parentWithFrameLayoutAndFixedSize.	
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 0@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopLeftInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignLeft.
	child constraints frame vertical alignTop.
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 40@10.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent 
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopRightInExactParent [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.

	parent := self parentWithFrameLayoutAndFixedSize.
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 300@0.
	self assert: child extent equals: 100@50.
	
	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - alignment' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAlignTopRightInExactParentWithPadding [
	<gtExample>
	| child parent |
	child := self childElementWithExactSize100per50.
	child constraints frame horizontal alignRight.
	child constraints frame vertical alignTop.
	
	parent := self parentWithFrameLayoutAndFixedSize.
	parent constraints padding: (BlInsets top: 10 right: 20 bottom: 30 left: 40).
	parent addChild: child.

	parent forceLayout.

	self assert: child position equals: 280@10.
	self assert: child extent equals: 100@50.

	self assert: parent position equals: 0@0.
	self assert: parent extent equals: 400@300.
	
	^ parent
]

{ #category : #'examples - fit content' }
BlFrameLayoutSingleChildExamples >> elementWithOneExactChildAndFitContentParent [
	<gtExample>
	| child aParent |
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c | 
		c vertical exact: 140.
		c horizontal exact: 140 ].
	aParent := BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	
	aParent addChild: child.
	aParent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 140@140.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 140@140.
	
	^ aParent
]

{ #category : #'examples - fit content' }
BlFrameLayoutSingleChildExamples >> elementWithOneMatchParentChildAndFitContentParent [
	<gtExample>
	| child aParent |
	child := self childElementWithVisualProperties.
	child constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	aParent := BlElement new
		layout: BlFrameLayout new;
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ].
	
	aParent addChild: child.
	aParent forceLayout.
	
	self assert: child position equals: 0@0.
	self assert: child extent equals: 0@0.
	
	self assert: aParent position equals: 0@0.
	self assert: aParent extent equals: 0@0.
	
	^ aParent
]
