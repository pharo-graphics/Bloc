"
I have been automatically converted and probably manually tweaked from BlFitContentVerticallyInHorizontalLayoutsExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlFitContentVerticallyInHorizontalLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> blue [

	<sampleInstance>
	<demo>
	^ self box
		  extent: self blueWidth @ self blueHeight;
		  border: (BlBorder paint: (Color blue alpha: 0.6) width: 1);
		  background: (Color blue alpha: 0.3);
		  margin: self blueMargin
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> blueHeight [

	^ 100
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> blueMargin [

	^ BlInsets right: self boxMargin
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> blueWidth [

	^ 75
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> box [

	<sampleInstance>
	<demo>
	^ BlElement new
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> boxMargin [

	^ 15
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> container [

	<sampleInstance>
	<demo>
	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical fitContent ];
		  background: (Color gray alpha: 0.2);
		  padding: (BlInsets all: self containerPadding)
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> containerPadding [

	^ 25
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> flow [

	<sampleInstance>
	<demo>
	^ self container
		  layout: BlFlowLayout horizontal;
		  addChild: (self layoutLabel: 'Flow')
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> green [

	<sampleInstance>
	<demo>
	^ self box
		  extent: self greenWidth @ self greenHeight;
		  border:
			  (BlBorder paint: (Color green muchDarker alpha: 0.6) width: 1);
		  background: (Color green darker alpha: 0.3);
		  margin: self greenMargin
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> greenHeight [

	^ 80
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> greenMargin [

	^ BlInsets top: self boxMargin
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> greenWidth [

	^ 150
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> grid [

	<sampleInstance>
	<demo>
	^ self container
		  layout: BlGridLayout horizontal;
		  addChild: (self layoutLabel: 'Grid')
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> layoutLabel: aString [

	^ BlTextElement new
		  text: (aString asRopedText thin fontSize: 10);
		  padding: (BlInsets top: 5);
		  constraintsDo: [ :c |
			  c ignoreByLayout.
			  c ignored horizontal alignCenter ];
		  yourself
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> list [

	<sampleInstance>
	<demo>
	^ self container
		  layout: BlLinearLayout horizontal;
		  addChild: (self layoutLabel: 'List')
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> oneColumnExtentDepth: aNumber [

	^ (self oneColumnWidthDepth: aNumber)
	  @ (self oneColumnHeightDepth: aNumber)
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> oneColumnHeight [

	^ {
		  (self redHeight + self redMargin height).
		  (self blueHeight + self blueMargin height).
		  (self greenHeight + self greenMargin height) } sum
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> oneColumnHeightDepth: aNumber [

	^ self oneColumnHeight + (self containerPadding * 2 * aNumber)
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> oneColumnWidth [

	^ {
		  (self redWidth + self redMargin width).
		  (self blueWidth + self blueMargin width).
		  (self greenWidth + self greenMargin width) } max
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> oneColumnWidthDepth: aNumber [

	^ self oneColumnWidth + (self containerPadding * 2 * aNumber)
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> red [

	<sampleInstance>
	<demo>
	^ self box
		  extent: self redWidth @ self redHeight;
		  background: (Color red alpha: 0.3);
		  border: (BlBorder paint: (Color red alpha: 0.6) width: 1);
		  margin: self redMargin
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> redHeight [

	^ 75
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> redMargin [

	^ BlInsets
		  top: 0
		  right: self boxMargin
		  bottom: self boxMargin
		  left: 0
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> redWidth [

	^ 100
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testOneColumnFlow [

	<sampleInstance>
	<demo>
	| flow |
	flow := self flow.
	flow width: (self oneColumnWidthDepth: 1).
	flow addChildren: {
			self red.
			self blue.
			self green }.
	flow forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).

	^ flow
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testOneColumnFlowGridGrid [

	<sampleInstance>
	<demo>
	| flow firstGrid secondGrid |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	firstGrid := self grid.
	firstGrid addChild: flow.

	secondGrid := self grid.
	secondGrid width: (self oneColumnWidthDepth: 3).
	secondGrid addChild: firstGrid.
	secondGrid forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	self assert: firstGrid extent equals: (self oneColumnExtentDepth: 2).
	self assert: secondGrid extent equals: (self oneColumnExtentDepth: 3).

	^ secondGrid
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testOneColumnFlowList [

	<sampleInstance>
	<demo>
	| flow list |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	list := self list.
	list width: (self oneColumnWidthDepth: 2) + 1.
	list addChild: flow.

	list forceLayout.
	list width: (self oneColumnWidthDepth: 2).
	list forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	self assert: list extent equals: (self oneColumnExtentDepth: 2).

	^ list
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testOneColumnFlowListGrid [

	<sampleInstance>
	<demo>
	| flow list grid |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	list := self list.
	list addChild: flow.

	grid := self grid.
	grid width: (self oneColumnWidthDepth: 3).
	grid addChild: list.
	grid forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	self assert: list extent equals: (self oneColumnExtentDepth: 2).
	self assert: grid extent equals: (self oneColumnExtentDepth: 3).

	^ grid
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testOneColumnFlowListList [

	<sampleInstance>
	<demo>
	| flow firstList secondList |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	firstList := self list.
	firstList addChild: flow.

	secondList := self list.
	secondList width: (self oneColumnWidthDepth: 3).
	secondList addChild: firstList.
	secondList forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	self assert: firstList extent equals: (self oneColumnExtentDepth: 2).
	self assert: secondList extent equals: (self oneColumnExtentDepth: 3).

	^ secondList
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testThreeColumnFlowGridGrid [

	<sampleInstance>
	<demo>
	| flow firstGrid secondGrid |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	firstGrid := self grid.
	firstGrid addChild: flow.

	secondGrid := self grid.
	secondGrid width: (self threeColumnWidthDepth: 3).
	secondGrid addChild: firstGrid.
	secondGrid forceLayout.

	self assert: flow extent equals: (self threeColumnExtentDepth: 1).
	self
		assert: firstGrid extent
		equals: (self threeColumnExtentDepth: 2).
	self
		assert: secondGrid extent
		equals: (self threeColumnExtentDepth: 3).

	^ secondGrid
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testThreeColumnFlowListGrid [

	<sampleInstance>
	<demo>
	| flow list grid |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	list := self list.
	list addChild: flow.

	grid := self grid.
	grid width: (self threeColumnWidthDepth: 3).
	grid addChild: list.
	grid forceLayout.

	self assert: flow extent equals: (self threeColumnExtentDepth: 1).
	self assert: list extent equals: (self threeColumnExtentDepth: 2).
	self assert: grid extent equals: (self threeColumnExtentDepth: 3).

	^ grid
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testThreeColumnFlowListList [

	<sampleInstance>
	<demo>
	| flow firstList secondList |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	firstList := self list.
	firstList addChild: flow.

	secondList := self list.
	secondList width: (self threeColumnWidthDepth: 3).
	secondList addChild: firstList.
	secondList forceLayout.

	self assert: flow extent equals: (self threeColumnExtentDepth: 1).
	self
		assert: firstList extent
		equals: (self threeColumnExtentDepth: 2).
	self
		assert: secondList extent
		equals: (self threeColumnExtentDepth: 3).

	^ secondList
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testTwoColumnFlow [

	<sampleInstance>
	<demo>
	| flow |
	flow := self flow.
	flow width: (self twoColumnWidthDepth: 1).
	flow addChildren: {
			self red.
			self blue.
			self green }.
	flow forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).

	^ flow
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testTwoColumnFlowFlowFlow [

	<sampleInstance>
	<demo>
	| firstFlow secondFlow thirdFlow |
	firstFlow := self flow.
	firstFlow addChildren: {
			self red.
			self blue.
			self green }.

	secondFlow := self flow.
	secondFlow addChild: firstFlow.

	thirdFlow := self flow.
	thirdFlow width: (self twoColumnWidthDepth: 3).
	thirdFlow addChild: secondFlow.
	thirdFlow forceLayout.

	self assert: firstFlow extent equals: (self twoColumnExtentDepth: 1).
	self assert: secondFlow extent equals: (self twoColumnExtentDepth: 2).
	self assert: thirdFlow extent equals: (self twoColumnExtentDepth: 3).

	^ thirdFlow
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testTwoColumnFlowFlowList [

	<sampleInstance>
	<demo>
	| firstFlow secondFlow list |
	firstFlow := self flow.
	firstFlow addChildren: {
			self red.
			self blue.
			self green }.

	secondFlow := self flow.
	secondFlow addChild: firstFlow.

	list := self list.
	list width: (self twoColumnWidthDepth: 3).
	list addChild: secondFlow.
	list forceLayout.

	self assert: firstFlow extent equals: (self twoColumnExtentDepth: 1).
	self assert: secondFlow extent equals: (self twoColumnExtentDepth: 2).
	self assert: list extent equals: (self twoColumnExtentDepth: 3).

	^ list
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testTwoColumnFlowGridGrid [

	<sampleInstance>
	<demo>
	| flow firstGrid secondGrid |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	firstGrid := self grid.
	firstGrid addChild: flow.

	secondGrid := self grid.
	secondGrid width: (self twoColumnWidthDepth: 3).
	secondGrid addChild: firstGrid.
	secondGrid forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: firstGrid extent equals: (self twoColumnExtentDepth: 2).
	self assert: secondGrid extent equals: (self twoColumnExtentDepth: 3).

	^ secondGrid
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testTwoColumnFlowGridList [

	<sampleInstance>
	<demo>
	| flow grid list |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	grid := self grid.
	grid addChild: flow.

	list := self list.
	list width: (self twoColumnWidthDepth: 3).
	list addChild: grid.
	list forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: grid extent equals: (self twoColumnExtentDepth: 2).
	self assert: list extent equals: (self twoColumnExtentDepth: 3).

	^ list
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testTwoColumnFlowList [

	<sampleInstance>
	<demo>
	| flow list |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	list := self list.
	list width: (self twoColumnWidthDepth: 2).
	list addChild: flow.
	list forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: list extent equals: (self twoColumnExtentDepth: 2).

	^ list
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testTwoColumnFlowListGrid [

	<sampleInstance>
	<demo>
	| flow list grid |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	list := self list.
	list addChild: flow.

	grid := self grid.
	grid width: (self twoColumnWidthDepth: 3).
	grid addChild: list.
	grid forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: list extent equals: (self twoColumnExtentDepth: 2).
	self assert: grid extent equals: (self twoColumnExtentDepth: 3).

	^ grid
]

{ #category : #tests }
BlFitContentVerticallyInHorizontalLayoutTest >> testTwoColumnFlowListList [

	<sampleInstance>
	<demo>
	| flow firstList secondList |
	flow := self flow.
	flow addChildren: {
			self red.
			self blue.
			self green }.

	firstList := self list.
	firstList addChild: flow.

	secondList := self list.
	secondList width: (self twoColumnWidthDepth: 3).
	secondList addChild: firstList.
	secondList forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: firstList extent equals: (self twoColumnExtentDepth: 2).
	self assert: secondList extent equals: (self twoColumnExtentDepth: 3).

	^ secondList
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> threeColumnExtentDepth: aNumber [

	^ (self threeColumnWidthDepth: aNumber)
	  @ (self threeColumnHeightDepth: aNumber)
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> threeColumnHeight [

	^ {
		  (self redHeight + self redMargin height).
		  (self blueHeight + self blueMargin height).
		  (self greenHeight + self greenMargin height) } max
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> threeColumnHeightDepth: aNumber [

	^ self threeColumnHeight + (self containerPadding * 2 * aNumber)
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> threeColumnWidth [

	^ {
		  (self redWidth + self redMargin width).
		  (self blueWidth + self blueMargin width).
		  (self greenWidth + self greenMargin width) } sum
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> threeColumnWidthDepth: aNumber [

	^ self threeColumnWidth + (self containerPadding * 2 * aNumber)
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> twoColumnExtentDepth: aNumber [

	^ (self twoColumnWidthDepth: aNumber)
	  @ (self twoColumnHeightDepth: aNumber)
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> twoColumnHeight [

	^ {
		  (self redHeight + self redMargin height).
		  (self blueHeight + self blueMargin height) } max
	  + self greenHeight + self greenMargin height
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> twoColumnHeightDepth: aNumber [

	^ self twoColumnHeight + (self containerPadding * 2 * aNumber)
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> twoColumnWidth [

	^ {
		  (self redWidth + self redMargin width + self blueWidth
		   + self blueMargin width).
		  (self greenWidth + self greenMargin width) } max
]

{ #category : #fixture }
BlFitContentVerticallyInHorizontalLayoutTest >> twoColumnWidthDepth: aNumber [

	^ self twoColumnWidth + (self containerPadding * 2 * aNumber)
]
