"
I have been automatically converted and probably manually tweaked from BlLinearLayoutHorizontalExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlLinearLayoutHorizontalTest,
	#superclass : #BlLinearLayoutTest,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testElementWithOneChildMatchInExactParentPadding [

	<sampleInstance>
	<demo>
	"A single child is distributed equally within the parent's bounds"
	| parent child |
	child := self testChildElementMatchingParent.
	parent := self testParentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 600.
	parent constraints padding: (BlInsets all: 20).
	parent addChildren: { child }.
	parent forceLayout.
	self assert: child extent equals: 360 @ 560.
	self assert: child position equals: 20 @ 20.
	self assert: parent extent equals: 400 @ 600.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testElementWithOneChildMatchOneExactInFitParent [
	"All children are distributed equally within parent's bounds"

	<sampleInstance>
	<demo>
	| parent childA childB |
	childA := self childExact: 300 @ 200.
	childB := self childExactWidth: 200.
	childB constraints vertical matchParent.
	parent := self testParentWithLinearHorizontalLayout.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.
	parent addChildren: {
			childA.
			childB }.
	parent forceLayout.
	self assert: childA extent equals: 300 @ 200.
	self assert: childA position equals: 0 @ 0.
	self assert: childB extent equals: 200 @ 200.
	self assert: childB position equals: 300 @ 0.
	self assert: parent extent equals: 500 @ 200.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testElementWithOneExactChildInExactParentMargin [
	"All children are distributed equally within parent's bounds"

	<sampleInstance>
	<demo>
	| parent childA |
	childA := self childExact: 20 @ 20.
	childA margin: (BlInsets
			 top: 15
			 right: 0
			 bottom: 0
			 left: 10).
	parent := self testParentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 50.
	parent constraints vertical exact: 50.
	parent addChildren: { childA }.
	parent forceLayout.
	self assert: childA extent equals: 20 @ 20.
	self assert: childA position equals: 10 @ 15.
	self assert: parent extent equals: 50 @ 50.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testElementWithThreeMatchChildrenInExactParent [
	"All children are distributed equally within parent's bounds"

	<sampleInstance>
	<demo>
	| parent childA childB childC |
	childA := self testChildElementMatchingParent.
	childB := self testChildElementMatchingParent.
	childC := self testChildElementMatchingParent.
	parent := self testParentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 200.
	parent addChildren: {
			childA.
			childB.
			childC }.
	parent forceLayout.
	self assert: childA extent equals: 200 @ 200.
	self assert: childA position equals: 0 @ 0.
	self assert: childB extent equals: 200 @ 200.
	self assert: childB position equals: 200 @ 0.
	self assert: childC extent equals: 200 @ 200.
	self assert: childC position equals: 400 @ 0.
	self assert: parent extent equals: 600 @ 200.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testElementWithThreeMatchChildrenInExactParentRTL [
	"All children are distributed equally within parent's bounds"

	<sampleInstance>
	<demo>
	| parent childA childB childC |
	childA := self testChildElementMatchingParent.
	childB := self testChildElementMatchingParent.
	childC := self testChildElementMatchingParent.
	parent := self testParentWithLinearHorizontalLayout.
	parent layout rightToLeft.
	parent constraints horizontal exact: 600.
	parent constraints vertical exact: 200.
	parent addChildren: {
			childA.
			childB.
			childC }.
	parent forceLayout.
	self assert: childC extent equals: 200 @ 200.
	self assert: childC position equals: 0 @ 0.
	self assert: childB extent equals: 200 @ 200.
	self assert: childB position equals: 200 @ 0.
	self assert: childA extent equals: 200 @ 200.
	self assert: childA position equals: 400 @ 0.
	self assert: parent extent equals: 600 @ 200.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testElementWithTwoChildrenMatchInExactParentPadding [
	"All children are distributed equally within parent's bounds"

	<sampleInstance>
	<demo>
	| parent childA childB |
	childA := self testChildElementMatchingParent.
	childB := self testChildElementMatchingParent.
	parent := self testParentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 600.
	parent constraints padding: (BlInsets all: 20).
	parent addChildren: {
			childA.
			childB }.
	parent forceLayout.
	self assert: childA extent equals: 180 @ 560.
	self assert: childA position equals: 20 @ 20.
	self assert: childB extent equals: 180 @ 560.
	self assert: childB position equals: 200 @ 20.
	self assert: parent extent equals: 400 @ 600.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testElementWithTwoExactChildrenInFitContent [
	"Parent resizes to fit children"

	<sampleInstance>
	<demo>
	| parent childA childB |
	childA := self childExact: 200 @ 100.
	childB := self childExact: 100 @ 200.
	parent := self testParentWithLinearHorizontalLayout.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.
	parent addChildren: {
			childA.
			childB }.
	parent forceLayout.
	self assert: childA extent equals: 200 @ 100.
	self assert: childA position equals: 0 @ 0.
	self assert: childB extent equals: 100 @ 200.
	self assert: childB position equals: 200 @ 0.
	self assert: parent extent equals: 300 @ 200.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testElementWithTwoMatchChildrenInExactParent [
	"All children are distributed equally within parent's bounds"

	<sampleInstance>
	<demo>
	| parent childA childB |
	childA := self testChildElementMatchingParent.
	childB := self testChildElementMatchingParent.
	parent := self testParentWithLinearHorizontalLayout.
	parent constraints horizontal exact: 500.
	parent constraints vertical exact: 200.
	parent addChildren: {
			childA.
			childB }.
	parent forceLayout.
	self assert: childA extent equals: 250 @ 200.
	self assert: childA position equals: 0 @ 0.
	self assert: childB extent equals: 250 @ 200.
	self assert: childB position equals: 250 @ 0.
	self assert: parent extent equals: 500 @ 200.
	self assert: parent position equals: 0 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testOneChildSetVisibilityGone [

	<sampleInstance>
	<demo>
	| aContainer aRed aBlue |
	aContainer := BlElement new
		              layout: (BlLinearLayout horizontal cellSpacing: 20);
		              padding: (BlInsets top: 10 bottom: 10);
		              extent: 500 @ 400.
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
	aContainer addChildren: {
			aRed.
			aBlue }.
	aContainer forceLayout.
	self assert: aContainer extent equals: 500 @ 400.
	self assert: aRed position equals: 20 @ 10.
	self assert: aRed extent equals: 220 @ 380.
	self assert: aBlue position equals: 260 @ 10.
	self assert: aBlue extent equals: 220 @ 380.
	aRed visibility: BlVisibility gone.
	aContainer forceLayout.
	self assert: aContainer extent equals: 500 @ 400.
	"red keeps its position and extent from the previous pass"
	self assert: aRed position equals: 20 @ 10.
	self assert: aRed extent equals: 220 @ 380.
	self assert: aBlue position equals: 20 @ 10.
	self assert: aBlue extent equals: 460 @ 380.
	^ aContainer
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testParentWithLinearHorizontalLayout [

	<sampleInstance>
	<demo>
	| element |
	element := BlElement new
		           border: (BlBorder builder
				            dashed;
				            paint: Color red;
				            width: 3;
				            build);
		           layout: BlLinearLayout horizontal.
	self assert: element layout class equals: BlLinearLayout.
	self assert: element layout isHorizontal.
	^ element
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testParentWithLinearHorizontalLayoutWithCellSpacing [

	| element child1 child2 |
	element := BlElement new layout: BlLinearLayout horizontal.
	self assert: element layout class equals: BlLinearLayout.
	self assert: element layout isHorizontal.
	element constraintsDo: [ :c | c horizontal fitContent ].
	child1 := BlElement new width: 0.
	child2 := BlElement new width: 0.
	element addChild: child1.
	element addChild: child2.
	element forceLayout.
	self assert: element width equals: 0.
	element layout: (BlLinearLayout horizontal cellSpacing: 5).
	element forceLayout.
	self assert: element width equals: 15.
	self assert: child1 position x equals: 5.
	self assert: child2 position x equals: 10
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testParentWithLinearLayoutWithCellSpacing [

	| element child1 child2 |
	element := BlElement new layout: BlLinearLayout vertical.
	self assert: element layout class equals: BlLinearLayout.
	self assert: element layout isVertical.
	element constraintsDo: [ :c | c vertical fitContent ].
	child1 := BlElement new height: 0.
	child2 := BlElement new height: 0.
	element addChild: child1.
	element addChild: child2.
	element forceLayout.
	self assert: element height equals: 0.
	element layout: (BlLinearLayout vertical cellSpacing: 5).
	element forceLayout.
	self assert: element height equals: 15.
	self assert: child1 position y equals: 5.
	self assert: child2 position y equals: 10.
	element removeChildren.
	element addChild: child1.
	element addChild: child2.
	element forceLayout.
	self assert: element height equals: 15.
	element layout: (BlLinearLayout vertical cellSpacing: 5).
	element forceLayout.
	self assert: child1 position y equals: 5.
	self assert: child2 position y equals: 10
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testParentWithLinearLayoutWithCellSpacingChangingDirection [

	| element child1 child2 |
	element := BlElement new layout: BlLinearLayout vertical.
	self assert: element layout class equals: BlLinearLayout.
	self assert: element layout isVertical.
	element constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent ].
	child1 := BlElement new
		          height: 0;
		          width: 0.
	child2 := BlElement new
		          height: 0;
		          width: 0.
	element addChild: child1.
	element addChild: child2.
	element forceLayout.
	self assert: element height equals: 0.
	self assert: element width equals: 0.
	element layout: (BlLinearLayout vertical cellSpacing: 5).
	element forceLayout.
	self assert: element height equals: 15.
	self assert: child1 position y equals: 5.
	self assert: child2 position y equals: 10.

	element layout: (BlLinearLayout horizontal cellSpacing: 5).
	element forceLayout.
	self assert: element width equals: 15.
	self assert: child1 position x equals: 5.
	self assert: child2 position x equals: 10.

	element layout: (BlLinearLayout vertical cellSpacing: 5).
	element forceLayout.
	self assert: element height equals: 15.
	self assert: child1 position y equals: 5.
	self assert: child2 position y equals: 10.

	element layout: (BlLinearLayout horizontal cellSpacing: 5).
	element forceLayout.
	self assert: element width equals: 15.
	self assert: child1 position x equals: 5.
	self assert: child2 position x equals: 10
]

{ #category : #tests }
BlLinearLayoutHorizontalTest >> testParentWithLinearVerticalLayoutWithCellSpacing [

	| element child1 child2 |
	element := BlElement new layout: BlLinearLayout vertical.
	element constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear horizontal alignCenter ].
	self assert: element layout class equals: BlLinearLayout.
	self assert: element layout isVertical.
	element constraintsDo: [ :c | c vertical fitContent ].
	child1 := BlElement new height: 0.
	child2 := BlElement new height: 0.
	element addChild: child1.
	element addChild: child2.
	element forceLayout.
	self assert: element height equals: 0.
	element layout: (BlLinearLayout vertical cellSpacing: 5).
	element forceLayout.
	self assert: element height equals: 15.
	self assert: child1 position y equals: 5.
	self assert: child2 position y equals: 10.
	element removeChildren.
	element addChild: child1.
	element addChild: child2.
	element forceLayout.
	self assert: element height equals: 15.
	element layout: (BlLinearLayout vertical cellSpacing: 5).
	element forceLayout.
	self assert: child1 position y equals: 5.
	self assert: child2 position y equals: 10
]
