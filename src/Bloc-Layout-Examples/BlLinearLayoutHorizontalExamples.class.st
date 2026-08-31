Class {
	#name : #BlLinearLayoutHorizontalExamples,
	#superclass : #BlLinearLayoutExamples,
	#category : #'Bloc-Layout-Examples-LinearMigrated'
}

{ #category : #examples }
BlLinearLayoutHorizontalExamples >> elementWithOneChildMatchInExactParentPadding [
	<gtExample>
	<description: 'A single child is distributed equally within the parent''s bounds'>
	| parent child |
	child := self childElementMatchingParent.

	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 600.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { child }.

	parent forceLayout.

	self assert: child extent equals: 360@560.
	self assert: child position equals: 20@20.

	self assert: parent extent equals: 400@600.
	self assert: parent position equals: 0@0.
	^ parent
]

{ #category : #examples }
BlLinearLayoutHorizontalExamples >> elementWithOneChildMatchOneExactInFitParent [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA childB |
	childA := self childExact: 300@200.
	childB := self childExactWidth: 200.
	childB constraints vertical matchParent.

	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 300@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 300@0.

	self assert: parent extent equals: 500@200.
	self assert: parent position equals: 0@0.
	^ parent
	
]

{ #category : #examples }
BlLinearLayoutHorizontalExamples >> elementWithOneExactChildInExactParentMargin [
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
BlLinearLayoutHorizontalExamples >> elementWithThreeMatchChildrenInExactParent [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA childB childC |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	childC := self childElementMatchingParent.
	
	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 200.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childA extent equals: 200@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 200@0.
	
	self assert: childC extent equals: 200@200.
	self assert: childC position equals: 400@0.

	self assert: parent extent equals: 600@200.
	self assert: parent position equals: 0@0.
	
	^ parent
]

{ #category : #examples }
BlLinearLayoutHorizontalExamples >> elementWithThreeMatchChildrenInExactParentRTL [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA childB childC |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	childC := self childElementMatchingParent.
	
	parent := self parentWithLinearHorizontalLayout.
	parent layout rightToLeft.
	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 200.

	parent addChildren: { childA . childB . childC }.

	parent forceLayout.

	self assert: childC extent equals: 200@200.
	self assert: childC position equals: 0@0.

	self assert: childB extent equals: 200@200.
	self assert: childB position equals: 200@0.
	
	self assert: childA extent equals: 200@200.
	self assert: childA position equals: 400@0.

	self assert: parent extent equals: 600@200.
	self assert: parent position equals: 0@0.
	
	^ parent
]

{ #category : #examples }
BlLinearLayoutHorizontalExamples >> elementWithTwoChildrenMatchInExactParentPadding [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA childB |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.

	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 600.
	parent constraints padding: (BlInsets all: 20).

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 180@560.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 180@560.
	self assert: childB position equals: 200@20.

	self assert: parent extent equals: 400@600.
	self assert: parent position equals: 0@0.
	
	^ parent
]

{ #category : #examples }
BlLinearLayoutHorizontalExamples >> elementWithTwoExactChildrenInFitContent [
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
	self assert: childB position equals: 200@0.
	
	self assert: parent extent equals: 300@200.
	self assert: parent position equals: 0@0.
	
	^ parent
]

{ #category : #examples }
BlLinearLayoutHorizontalExamples >> elementWithTwoMatchChildrenInExactParent [
	<gtExample>
	"All children are distributed equally within parent's bounds"
	| parent childA childB |
	childA := self childElementMatchingParent.
	childB := self childElementMatchingParent.
	
	parent := self parentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 200.

	parent addChildren: { childA . childB }.

	parent forceLayout.

	self assert: childA extent equals: 250@200.
	self assert: childA position equals: 0@0.

	self assert: childB extent equals: 250@200.
	self assert: childB position equals: 250@0.

	self assert: parent extent equals: 500@200.
	self assert: parent position equals: 0@0.
	
	^ parent
]

{ #category : #'examples - visibility' }
BlLinearLayoutHorizontalExamples >> one_child_set_visibility_gone [
	<gtExample>
	| aContainer aRed aBlue |
	
	aContainer := BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 20);
		padding: (BlInsets top: 10 bottom: 10);
		extent: 500@400.
		
	aRed := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: Color red darker width: 1);
		background: (Color red alpha: 0.3).
		
	aBlue := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		border: (BlBorder paint: Color blue darker width: 1);
		background: (Color blue alpha: 0.3).
		
	aContainer addChildren: { aRed . aBlue }.
	
	aContainer forceLayout.
	
	self assert: aContainer extent equals: 500@400.
	self assert: aRed position equals: 20@10.
	self assert: aRed extent equals: 220@380.
	
	self assert: aBlue position equals: 260@10.
	self assert: aBlue extent equals: 220@380.
	
	aRed visibility: BlVisibility gone.
	
	aContainer forceLayout.
	
	self assert: aContainer extent equals: 500@400.
	"red keeps its position and extent from the previous pass"
	self assert: aRed position equals: 20@10.
	self assert: aRed extent equals: 220@380.
	
	self assert: aBlue position equals: 20@10.
	self assert: aBlue extent equals: 460@380.
	
	^ aContainer
]

{ #category : #'examples - setup' }
BlLinearLayoutHorizontalExamples >> parentWithLinearHorizontalLayout [
	<gtExample>
	| element |
	element :=  BlElement new
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		layout: BlLinearLayout horizontal.
	
	self assert: element layout class equals: BlLinearLayout.
	self assert: element layout isHorizontal.
	
	^ element
]
