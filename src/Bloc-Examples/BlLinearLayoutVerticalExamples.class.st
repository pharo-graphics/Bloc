Class {
	#name : #BlLinearLayoutVerticalExamples,
	#superclass : #Object,
	#traits : 'TBlLayoutExamplesSetup',
	#classTraits : 'TBlLayoutExamplesSetup classTrait',
	#category : #'Bloc-Examples-Layout'
}

{ #category : #examples }
BlLinearLayoutVerticalExamples >> elementWithChildMatchInExactParentPadding [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA |
	childA := self childElementMatchingParent.

	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 600.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { childA }.

	parent forceLayout.

	self assert: childA extent equals: 360@560.
	self assert: childA position equals: 20@20.

	self assert: parent extent equals: 400@600.
	self assert: parent position equals: 0@0.
	
	^ parent
]

{ #category : #examples }
BlLinearLayoutVerticalExamples >> elementWithChildrenMatchInExactParentPadding [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA childB |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	
	parent := self parentWithLinearHorizontalLayout.

	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 400.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 560@180.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 560@180.
	self assert: childB position equals: 20@200.

	self assert: parent extent equals: 600@400.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #examples }
BlLinearLayoutVerticalExamples >> elementWithExactChildrenInFitContent [
	<gtExample>
	"Parent resizes to fit children"
	| parent childA childB |
	childA := self childExact: 200@100.
	childB := self childExact: 100@200.
	
	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.
	
	parent addChildren: { childA . childB }.
	
	parent forceLayout.
	
	self assert: childA extent equals: 200@100.
	self assert: childA position equals: 0@0.
	
	self assert: childB extent equals: 100@200.
	self assert: childB position equals: 0@100.
	
	self assert: parent extent equals: 200@300.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #examples }
BlLinearLayoutVerticalExamples >> elementWithMatchChildrenInExactParent [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA childB childC |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	childC := self childElementMatchingParent.
	
	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 600.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 200@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 0@200.
	
	self assert: childC extent equals: 200@200.
	self assert: childC position equals: 0@400.

	self assert: parent extent equals: 200@600.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #examples }
BlLinearLayoutVerticalExamples >> elementWithOneChildMatchOneExactInFitParent [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA childB |
	childA := self childExact: 200@300.
	childB := self childExactHeight: 200.
	childB constraints horizontal matchParent.

	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 200@300.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 0@300.

	self assert: parent extent equals: 200@500.
	self assert: parent position equals: 0@0.
	
	^ parent
]

{ #category : #examples }
BlLinearLayoutVerticalExamples >> elementWithOneExactChildInExactParentMargin [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA |
	childA := self childExact: 20@20.
	childA margin: (BlInsets top: 15 right: 0 bottom: 0 left: 10).
	
	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 50.
	parent constraints vertical exact: 50.

	parent addChildren: { childA }.

	parent forceLayout.

	self assert: childA extent equals: 20@20.
	self assert: childA position equals: 10@15.

	self assert: parent extent equals: 50@50.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #examples }
BlLinearLayoutVerticalExamples >> elementWithThreeExactChildrenAlignInExactParentLTR [
	<gtExample>
	| parent childA childB childC |
	childA := self childExact: 100@100.
	childB := self childExact: 200@100.
	childC := self childExact: 50@100.
	
	childA constraints linear horizontal alignLeft.
	childB constraints linear horizontal alignCenter.
	childC constraints linear horizontal alignRight.
	
	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 600.
	
	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 100@100.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@100.
	self assert: childB position equals: 150@100.
	
	self assert: childC extent equals: 50@100.
	self assert: childC position equals: 450@200.

	self assert: parent extent equals: 500@600.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #examples }
BlLinearLayoutVerticalExamples >> elementWithThreeExactChildrenAlignInExactParentRTL [
	<gtExample>
	| parent childA childB childC |

	childA := self childExact: 100@100.
	childB := self childExact: 200@100.
	childC := self childExact: 50@100.

	childA constraints linear horizontal alignLeft.
	childB constraints linear horizontal alignCenter.
	childC constraints linear horizontal alignRight.

	parent := self parentWithLinearHorizontalLayout.
	parent layout rightToLeft.
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 600.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 100@100.
	self assert: childA position equals: 400@0.

	self assert: childB extent equals: 200@100.
	self assert: childB position equals: 150@100.
	
	self assert: childC extent equals: 50@100.
	self assert: childC position equals: 0@200.

	self assert: parent extent equals: 500@600.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #'examples - setup' }
BlLinearLayoutVerticalExamples >> parentWithLinearHorizontalLayout [
	<gtExample>
	| element |
	element :=  BlElement new
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		layout: BlLinearLayout vertical.
	
	self assert: element layout class equals: BlLinearLayout.
	self assert: element layout isVertical.
	
	^ element
]
