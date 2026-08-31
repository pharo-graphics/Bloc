"
I have been automatically converted and probably manually tweaked from BlLinearLayoutUsageExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlLinearLayoutUsageTest,
	#superclass : #BlLinearLayoutTest,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlLinearLayoutUsageTest >> testEqualizingHeighAndWidth [

	<sampleInstance>
	<demo>
	| parent |
	parent := self twoChildrenMatchParentInFitContent.
	parent layoutDo: [ :aLayout | aLayout withSpaceEqualization ].
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testEqualizingWidth [

	<sampleInstance>
	<demo>
	| parent |
	"width is by default equalized"
	parent := self twoChildrenMatchParentInFitContent.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleHorizontalListFixedWidthLTR [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      border: (BlBorder paint: Color darkGray width: 4);
		      constraintsDo: [ :c |
			      c horizontal exact: 80.
			      c vertical matchParent ];
		      background: Color red.
	e2 := BlElement new
		      border: (BlBorder paint: Color black width: 4);
		      constraintsDo: [ :c |
			      c horizontal exact: 80.
			      c vertical matchParent ];
		      background: Color green.
	e3 := BlElement new
		      border: (BlBorder paint: Color lightGray width: 4);
		      constraintsDo: [ :c |
			      c horizontal exact: 80.
			      c vertical matchParent ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout horizontal;
		      extent: 450 @ 150;
		      position: 200 @ 100;
		      padding: (BlInsets all: 10);
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleHorizontalListFixedWidthRTL [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      border: (BlBorder paint: Color darkGray width: 4);
		      constraintsDo: [ :c |
			      c horizontal exact: 80.
			      c vertical matchParent ];
		      background: Color red.
	e2 := BlElement new
		      border: (BlBorder paint: Color black width: 4);
		      constraintsDo: [ :c |
			      c horizontal exact: 80.
			      c vertical matchParent ];
		      background: Color green.
	e3 := BlElement new
		      border: (BlBorder paint: Color lightGray width: 4);
		      constraintsDo: [ :c |
			      c horizontal exact: 80.
			      c vertical matchParent ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout horizontal rightToLeft;
		      extent: 450 @ 150;
		      position: 200 @ 100;
		      padding: (BlInsets all: 10);
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleHorizontalListLTR [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: Color green.
	e3 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout horizontal;
		      extent: 300 @ 80;
		      position: 200 @ 100;
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleHorizontalListRTL [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: Color green.
	e3 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout horizontal rightToLeft;
		      extent: 300 @ 80;
		      position: 200 @ 100;
		      background: Color veryVeryLightGray;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleHorizontalTopCenterBottomLTR [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c | c linear vertical alignTop ];
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c | c linear vertical alignCenter ];
		      background: Color green.
	e3 := BlElement new
		      constraintsDo: [ :c | c linear vertical alignBottom ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout horizontal;
		      extent: 300 @ 80;
		      position: 200 @ 100;
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleHorizontalTopCenterBottomRTL [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c | c linear vertical alignTop ];
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c | c linear vertical alignCenter ];
		      background: Color green.
	e3 := BlElement new
		      constraintsDo: [ :c | c linear vertical alignBottom ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout horizontal rightToLeft;
		      extent: 300 @ 80;
		      position: 200 @ 100;
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleHorizontalUsingWeightLTR [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent.
			      c linear weight: 1 ];
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent.
			      c linear weight: 2 ];
		      background: Color green.
	e3 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent.
			      c linear weight: 3 ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout horizontal;
		      extent: 300 @ 80;
		      position: 200 @ 100;
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleHorizontalUsingWeightRTL [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent.
			      c linear weight: 1 ];
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent.
			      c linear weight: 2 ];
		      background: Color green.
	e3 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent.
			      c linear weight: 3 ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout horizontal rightToLeft;
		      extent: 300 @ 80;
		      position: 200 @ 100;
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleVerticalLeftCenterRightLRT [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c |
			      c linear horizontal alignLeft.
			      c vertical exact: 100 ];
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal exact: 100.
			      c linear horizontal alignCenter ];
		      background: Color green.
	e3 := BlElement new
		      extent: 50 @ 50;
		      constraintsDo: [ :c | c linear horizontal alignRight ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout vertical;
		      extent: 200 @ 300;
		      position: 200 @ 100;
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleVerticalLeftCenterRightRTL [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c |
			      c vertical exact: 100.
			      c linear horizontal alignLeft ];
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal exact: 100.
			      c linear horizontal alignCenter ];
		      background: Color green.
	e3 := BlElement new
		      extent: 50 @ 50;
		      constraintsDo: [ :c | c linear horizontal alignRight ];
		      background: Color yellow.
	el := BlElement new
		      layout: BlLinearLayout vertical rightToLeft;
		      extent: 200 @ 300;
		      position: 200 @ 100;
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleVerticalList [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      border: (BlBorder paint: Color darkGray width: 4);
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      border: (BlBorder paint: Color black width: 4);
		      background: Color yellow.
	e3 := BlElement new
		      constraintsDo: [ :c |
			      c horizontal matchParent.
			      c vertical matchParent ];
		      border: (BlBorder paint: Color lightGray width: 4);
		      background: Color green.
	el := BlElement new
		      layout: BlLinearLayout vertical;
		      extent: 80 @ 300;
		      position: 200 @ 100;
		      padding: (BlInsets all: 10);
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testExampleVerticalListFixedHeight [

	<sampleInstance>
	<demo>
	| e1 e2 e3 el |
	e1 := BlElement new
		      constraintsDo: [ :c | c horizontal matchParent ];
		      border: (BlBorder paint: Color darkGray width: 4);
		      background: Color red.
	e2 := BlElement new
		      constraintsDo: [ :c | c horizontal matchParent ];
		      border: (BlBorder paint: Color black width: 4);
		      background: Color yellow.
	e3 := BlElement new
		      constraintsDo: [ :c | c horizontal matchParent ];
		      border: (BlBorder paint: Color lightGray width: 4);
		      background: Color green.
	el := BlElement new
		      layout: BlLinearLayout vertical;
		      extent: 80 @ 300;
		      position: 200 @ 100;
		      padding: (BlInsets all: 10);
		      background: Color blue;
		      addChildren: {
				      e1.
				      e2.
				      e3 }.
	^ el
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testMatchParentInFitContent [
	"If all children in the parent that fits content match parent then they should be measured with 0 size"

	<sampleInstance>
	<demo>
	| child parent |
	child := BlElement new.
	child layout: BlBasicLayout new.
	child background: (Color red alpha: 0.3).
	child border: (BlBorder paint: Color red width: 1).
	child constraintsDo: [ :c |
		c horizontal exact: 100.
		c vertical matchParent ].
	parent := BlElement new.
	parent layout: BlLinearLayout horizontal.
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 25).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical fitContent ].
	parent addChild: child.
	parent forceLayout.
	self assert: parent extent equals: 300 @ 50.
	self assert: child extent equals: 100 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testMatchParentInFitContentChangeBackToMatchParent [

	<sampleInstance>
	"Changing back to match parent should reset size to 0"
	| parent child |
	parent := self testMatchParentInFitContentChangeToExact.
	child := parent children first.
	child constraintsDo: [ :c | c vertical matchParent ].
	parent forceLayout.
	self assert: parent extent equals: 300 @ 50.
	self assert: child extent equals: 100 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testMatchParentInFitContentChangeToExact [
	"Now we change size to exact and expect parent to resize"

	<sampleInstance>
	<demo>
	| parent child |
	parent := self testMatchParentInFitContent.
	child := parent children first.
	child height: 200.
	parent forceLayout.
	self assert: parent extent equals: 300 @ 250.
	self assert: child extent equals: 100 @ 200.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testOneChildWithFitContentLimited [

	<sampleInstance>
	<demo>
	| subChildren child parent |
	subChildren := 4 timesCollect: [
		               BlElement new
			               background: Color blue;
			               margin: (BlInsets all: 10);
			               extent: 200 @ 150 ].
	child := BlElement new.
	child layout: BlLinearLayout vertical.
	child background: (Color red alpha: 0.3).
	child border: (BlBorder paint: Color red width: 2).
	child constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContentLimited ].
	child addChildren: subChildren.
	parent := BlElement new.
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 25).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChild: child.
	parent forceLayout.
	self assert: parent extent equals: 300 @ 400.
	self assert: child extent equals: 300 @ 400.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testOneChildWithFitContentLimitedAndAnotherChild [

	<sampleInstance>
	<demo>
	| subChildren childA childB parent |
	subChildren := 4 timesCollect: [
		               BlElement new
			               background: Color blue;
			               margin: (BlInsets all: 10);
			               extent: 200 @ 150 ].
	childA := BlElement new.
	childA layout: BlLinearLayout vertical.
	childA background: (Color red alpha: 0.3).
	childA border: (BlBorder paint: Color red width: 2).
	childA constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContentLimited ].
	childA addChildren: subChildren.
	childB := BlElement new.
	childB background: (Color blue alpha: 0.3).
	childB border: (BlBorder paint: Color blue width: 2).
	childB extent: 100 @ 75.
	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: {
			childA.
			childB }.
	parent forceLayout.
	self assert: parent extent equals: 300 @ 400.
	self assert: childA extent equals: 300 @ 325.
	self assert: childB extent equals: 100 @ 75.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testOneChildWithFitContentLimitedAndAnotherChildFitContent [

	<sampleInstance>
	<demo>
	| subChildren childA childB subChildB parent |
	subChildren := 4 timesCollect: [
		               BlElement new
			               background: Color blue;
			               margin: (BlInsets all: 10);
			               extent: 200 @ 150 ].
	childA := BlElement new.
	childA layout: BlLinearLayout vertical.
	childA background: (Color red alpha: 0.3).
	childA border: (BlBorder paint: Color red width: 2).
	childA constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContentLimited ].
	childA addChildren: subChildren.
	subChildB := BlElement new.
	subChildB background: (Color blue alpha: 0.3).
	subChildB border: (BlBorder paint: Color blue width: 2).
	subChildB extent: 100 @ 75.
	childB := BlElement new.
	childB layout: BlLinearLayout vertical.
	childB border: (BlBorder paint: Color blue width: 2).
	childB constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	childB addChild: subChildB.
	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: {
			childA.
			childB }.
	parent forceLayout.
	self assert: parent extent equals: 300 @ 400.
	self assert: childA extent equals: 300 @ 325.
	self assert: childB extent equals: 300 @ 75.
	self assert: subChildB extent equals: 100 @ 75.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testOneChildWithFitContentLimitedExceedsAndThreeChildlren [

	<sampleInstance>
	<demo>
	| subChildren childA childB childC childD parent |
	subChildren := 4 timesCollect: [
		               BlElement new
			               background: (Color red alpha: 0.5);
			               margin: (BlInsets all: 20);
			               extent: 200 @ 100 ].
	childA := BlElement new.
	childA layout: BlLinearLayout vertical.
	childA background: (Color red alpha: 0.3).
	childA border: (BlBorder paint: Color red width: 2).
	childA constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContentLimited ].
	childA addChildren: subChildren.
	childB := BlElement new.
	childB background: (Color blue alpha: 0.3).
	childB border: (BlBorder paint: Color blue width: 2).
	childB extent: 100 @ 75.
	childC := BlElement new.
	childC background: (Color blue alpha: 0.3).
	childC border: (BlBorder paint: Color blue width: 2).
	childC extent: 75 @ 50.
	childD := BlElement new.
	childD background: (Color green darker alpha: 0.3).
	childD border: (BlBorder paint: Color green muchDarker width: 2).
	childD constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	parent := BlElement new.
	parent layout: (BlLinearLayout vertical cellSpacing: 20).
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: {
			childC.
			childA.
			childB.
			childD }.
	parent padding: (BlInsets left: 20 right: 20).
	parent forceLayout.
	self assert: parent extent equals: 300 @ 400.
	self assert: childA extent equals: 260 @ 175.
	self assert: childB extent equals: 100 @ 75.
	self assert: childC extent equals: 75 @ 50.
	self assert: childD extent equals: 260 @ 0.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testOneChildWithFitContentLimitedExceedsAndTwoChildlren [

	<sampleInstance>
	<demo>
	| subChildren childA childB childC parent |
	subChildren := 4 timesCollect: [
		               BlElement new
			               background: (Color red alpha: 0.5);
			               margin: (BlInsets all: 20);
			               extent: 200 @ 100 ].
	childA := BlElement new.
	childA layout: BlLinearLayout vertical.
	childA background: (Color red alpha: 0.3).
	childA border: (BlBorder paint: Color red width: 2).
	childA constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContentLimited ].
	childA addChildren: subChildren.
	childB := BlElement new.
	childB background: (Color blue alpha: 0.3).
	childB border: (BlBorder paint: Color blue width: 2).
	childB extent: 100 @ 75.
	childC := BlElement new.
	childC background: (Color blue alpha: 0.3).
	childC border: (BlBorder paint: Color blue width: 2).
	childC extent: 75 @ 50.
	parent := BlElement new.
	parent layout: (BlLinearLayout vertical cellSpacing: 20).
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: {
			childC.
			childA.
			childB }.
	parent padding: (BlInsets left: 20 right: 20).
	parent forceLayout.
	self assert: parent extent equals: 300 @ 400.
	self assert: childA extent equals: 260 @ 195.
	self assert: childB extent equals: 100 @ 75.
	self assert: childC extent equals: 75 @ 50.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testOneChildWithFitContentLimitedExceedsNotAndThreeChildlren [

	<sampleInstance>
	<demo>
	| subChildren childA childB childC childD parent |
	subChildren := 1 timesCollect: [
		               BlElement new
			               background: (Color red alpha: 0.5);
			               margin: (BlInsets all: 20);
			               extent: 200 @ 100 ].
	childA := BlElement new.
	childA layout: BlLinearLayout vertical.
	childA background: (Color red alpha: 0.3).
	childA border: (BlBorder paint: Color red width: 2).
	childA constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContentLimited ].
	childA addChildren: subChildren.
	childB := BlElement new.
	childB background: (Color blue alpha: 0.3).
	childB border: (BlBorder paint: Color blue width: 2).
	childB extent: 100 @ 75.
	childC := BlElement new.
	childC background: (Color blue alpha: 0.3).
	childC border: (BlBorder paint: Color blue width: 2).
	childC extent: 75 @ 50.
	childD := BlElement new.
	childD background: (Color green darker alpha: 0.3).
	childD border: (BlBorder paint: Color green muchDarker width: 2).
	childD constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	parent := BlElement new.
	parent layout: (BlLinearLayout vertical cellSpacing: 20).
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: {
			childC.
			childA.
			childB.
			childD }.
	parent padding: (BlInsets left: 20 right: 20).
	parent forceLayout.
	self assert: parent extent equals: 300 @ 400.
	self assert: childA extent equals: 260 @ 140.
	self assert: childB extent equals: 100 @ 75.
	self assert: childC extent equals: 75 @ 50.
	self assert: childD extent equals: 260 @ 35.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testOneChildWithFitContentLimitedExceedsNotAndTwoChildlren [

	<sampleInstance>
	<demo>
	| subChildren childA childB childC parent |
	subChildren := 1 timesCollect: [
		               BlElement new
			               background: (Color red alpha: 0.5);
			               margin: (BlInsets all: 20);
			               extent: 200 @ 100 ].
	childA := BlElement new.
	childA layout: BlLinearLayout vertical.
	childA background: (Color red alpha: 0.3).
	childA border: (BlBorder paint: Color red width: 2).
	childA constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContentLimited ].
	childA addChildren: subChildren.
	childB := BlElement new.
	childB background: (Color blue alpha: 0.3).
	childB border: (BlBorder paint: Color blue width: 2).
	childB extent: 100 @ 75.
	childC := BlElement new.
	childC background: (Color blue alpha: 0.3).
	childC border: (BlBorder paint: Color blue width: 2).
	childC extent: 75 @ 50.
	parent := BlElement new.
	parent layout: (BlLinearLayout vertical cellSpacing: 20).
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: {
			childC.
			childA.
			childB }.
	parent padding: (BlInsets left: 20 right: 20).
	parent forceLayout.
	self assert: parent extent equals: 300 @ 400.
	self assert: childA extent equals: 260 @ 140.
	self assert: childB extent equals: 100 @ 75.
	self assert: childC extent equals: 75 @ 50.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testTwoChildrenMatchParentInFitContent [

	<sampleInstance>
	<demo>
	| parent child child2 |
	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 25).
	parent constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	child := BlTextElement new.
	child text: ('Hello world haba' asRopedText fontSize: 40).
	child background: (Color red alpha: 0.3).
	child margin: (BlInsets all: 5).
	child border: (BlBorder paint: Color red width: 1).
	child constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	child2 := BlTextElement new.
	child2 text: ('Hello' asRopedText fontSize: 15).
	child2 background: (Color blue alpha: 0.3).
	child2 margin: (BlInsets all: 5).
	child2 border: (BlBorder paint: Color blue width: 1).
	child2 constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	parent addChild: child.
	parent addChild: child2.
	parent forceLayout.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> testTwoChildrenOnOppositeSidesWithSpan [

	<sampleInstance>
	<demo>
	| parent left span right |
	parent := BlElement new.
	parent background: (Color gray alpha: 0.3).
	parent layout: BlLinearLayout horizontal.
	parent constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	left := BlElement new.
	left background: (Color red alpha: 0.3).
	left border: (BlBorder paint: Color red width: 1).
	left margin: (BlInsets all: 5).
	left constraintsDo: [ :c |
		c horizontal exact: 200.
		c vertical exact: 50.
		c grid vertical alignCenter.
		c grid horizontal alignLeft ].
	span := BlElement new.
	span border: (BlBorder builder dashed
			 width: 1;
			 paint: Color gray;
			 build).
	span margin: (BlInsets all: 5).
	span constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	right := BlElement new.
	right margin: (BlInsets all: 5).
	right background: (Color blue alpha: 0.3).
	right border: (BlBorder paint: Color blue width: 1).
	right constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 30.
		c linear vertical alignCenter ].
	parent addChildren: {
			left.
			span.
			right }.
	^ parent
]

{ #category : #tests }
BlLinearLayoutUsageTest >> twoChildrenMatchParentInFitContent [

	<sampleInstance>
	<demo>
	| parent child child2 |
	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
	parent background: (Color gray alpha: 0.3).
	parent padding: (BlInsets all: 25).
	parent constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	child := BlTextElement new.
	child text: ('Hello world haba' asRopedText fontSize: 40).
	child background: (Color red alpha: 0.3).
	child margin: (BlInsets all: 5).
	child border: (BlBorder paint: Color red width: 1).
	child constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	child2 := BlTextElement new.
	child2 text: ('Hello' asRopedText fontSize: 15).
	child2 background: (Color blue alpha: 0.3).
	child2 margin: (BlInsets all: 5).
	child2 border: (BlBorder paint: Color blue width: 1).
	child2 constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	parent addChild: child.
	parent addChild: child2.
	parent forceLayout.
	^ parent
]
