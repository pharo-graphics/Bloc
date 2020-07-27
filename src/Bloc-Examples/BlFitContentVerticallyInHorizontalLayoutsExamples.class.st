"
I exemplify what happens if we compose horizontal grid, linear and flow layout and configure them to fit content vertically.

This is a very important use case for complex UIs that involve vertical lists
"
Class {
	#name : #BlFitContentVerticallyInHorizontalLayoutsExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Layout'
}

{ #category : #'instance creation' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> blue [
	<gtExample>

	^ self box
		size: self blueWidth @ self blueHeight;
		border: (BlBorder paint: (Color blue alpha: 0.6) width: 1);
		background: (Color blue alpha: 0.3);
		margin: self blueMargin
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> blueHeight [
	^ 100
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> blueMargin [
	^ BlInsets right: self boxMargin
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> blueWidth [
	^ 75
]

{ #category : #'instance creation' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> box [
	<gtExample>
	
	^ BlElement new
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> boxMargin [
	^ 15
]

{ #category : #'instance creation' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> container [
	<gtExample>
	
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		background: (Color gray alpha: 0.2);
		padding: (BlInsets all: self containerPadding)
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> containerPadding [
	^ 25
]

{ #category : #'instance creation' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> flow [
	<gtExample>
	
	^ self container
		layout: BlFlowLayout horizontal;
		addChild: (self layoutLabel: 'Flow')
]

{ #category : #'instance creation' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> green [
	<gtExample>

	^ self box
		size: self greenWidth @ self greenHeight;
		border: (BlBorder paint: (Color green muchDarker alpha: 0.6) width: 1);
		background: (Color green darker alpha: 0.3);
		margin: self greenMargin
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> greenHeight [
	^ 80
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> greenMargin [
	^ BlInsets top: self boxMargin
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> greenWidth [
	^ 150
]

{ #category : #'instance creation' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> grid [
	<gtExample>
	
	^ self container
		layout: BlGridLayout horizontal;
		addChild: (self layoutLabel: 'Grid')
]

{ #category : #'private - helpers' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> layoutLabel: aString [
	^ BlTextElement new
		text: (aString asRopedText thin fontSize: 10);
		padding: (BlInsets top: 5);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignCenter ]
]

{ #category : #'private - helpers' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> leftResizer: anElement [
	^ BlElement new
		background: (Color gray alpha: 0.4);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		width: 6;
		constraintsDo: [ :c |
			c vertical matchParent.
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignCenter.
			c ignored vertical weight: 0.5 ];
		addEventHandler: (BlResizerRightListener new resizeTarget: anElement; minimumExtent: 50@0)
]

{ #category : #'instance creation' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> list [
	<gtExample>
	
	^ self container
		layout: BlLinearLayout horizontal;
		addChild: (self layoutLabel: 'List')
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnExtentDepth: aNumber [

	^ (self oneColumnWidthDepth: aNumber) @ (self oneColumnHeightDepth: aNumber)
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnFlow [
	<gtExample>
	| flow |

	flow := self flow.
	flow width: (self oneColumnWidthDepth: 1).
	flow addChild: (self leftResizer: flow).
	flow addChildren: { self red. self blue. self green }.
	flow forceLayout.
	
	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	
	^ flow
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnFlowGridGrid [
	<gtExample>
	| flow firstGrid secondGrid |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	firstGrid := self grid.
	firstGrid addChild: flow.
	
	secondGrid := self grid.
	secondGrid width: (self oneColumnWidthDepth: 3).
	secondGrid addChild: (self leftResizer: secondGrid).
	secondGrid addChild: firstGrid.
	secondGrid forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	self assert: firstGrid extent equals: (self oneColumnExtentDepth: 2).
	self assert: secondGrid extent equals: (self oneColumnExtentDepth: 3).

	^ secondGrid
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnFlowList [
	<gtExample>
	| flow list |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.
	
	list := self list.
	list width: (self oneColumnWidthDepth: 2) + 1.
	list addChild: (self leftResizer: list).
	list addChild: flow.
	
	list forceLayout.
	list width: (self oneColumnWidthDepth: 2).
	list forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	self assert: list extent equals: (self oneColumnExtentDepth: 2).
	
	^ list
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnFlowListGrid [
	<gtExample>
	| flow list grid |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	list := self list.
	list addChild: flow.
	
	grid := self grid.
	grid width: (self oneColumnWidthDepth: 3).
	grid addChild: (self leftResizer: grid).
	grid addChild: list.
	grid forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	self assert: list extent equals: (self oneColumnExtentDepth: 2).
	self assert: grid extent equals: (self oneColumnExtentDepth: 3).

	^ grid
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnFlowListList [
	<gtExample>
	| flow firstList secondList |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	firstList := self list.
	firstList addChild: flow.
	
	secondList := self list.
	secondList width: (self oneColumnWidthDepth: 3).
	secondList addChild: (self leftResizer: secondList).
	secondList addChild: firstList.
	secondList forceLayout.

	self assert: flow extent equals: (self oneColumnExtentDepth: 1).
	self assert: firstList extent equals: (self oneColumnExtentDepth: 2).
	self assert: secondList extent equals: (self oneColumnExtentDepth: 3).

	^ secondList
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnHeight [

	^ {
		self redHeight + self redMargin height.
		self blueHeight + self blueMargin height.
		self greenHeight + self greenMargin height.
	} sum
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnHeightDepth: aNumber [

	^ self oneColumnHeight + ((self containerPadding * 2) * aNumber)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnWidth [

	^ {
		self redWidth + self redMargin width.
		self blueWidth + self blueMargin width.
		self greenWidth + self greenMargin width.
	} max
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnWidthDepth: aNumber [

	^ self oneColumnWidth + ((self containerPadding * 2) * aNumber)
]

{ #category : #'instance creation' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> red [
	<gtExample>

	^ self box
		size: self redWidth @ self redHeight;
		background: (Color red alpha: 0.3);
		border: (BlBorder paint: (Color red alpha: 0.6) width: 1);
		margin: self redMargin
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> redHeight [
	^ 75
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> redMargin [
	^ (BlInsets top: 0 right: self boxMargin bottom: self boxMargin left: 0)
]

{ #category : #'private - configuration' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> redWidth [
	^ 100
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnExtentDepth: aNumber [

	^ (self threeColumnWidthDepth: aNumber) @ (self threeColumnHeightDepth: aNumber)
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnFlowGridGrid [
	<gtExample>
	| flow firstGrid secondGrid |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	firstGrid := self grid.
	firstGrid addChild: flow.

	secondGrid := self grid.
	secondGrid width: (self threeColumnWidthDepth: 3).
	secondGrid addChild: (self leftResizer: secondGrid).
	secondGrid addChild: firstGrid.
	secondGrid forceLayout.

	self assert: flow extent equals: (self threeColumnExtentDepth: 1).
	self assert: firstGrid extent equals: (self threeColumnExtentDepth: 2).
	self assert: secondGrid extent equals: (self threeColumnExtentDepth: 3).

	^ secondGrid
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnFlowListGrid [
	<gtExample>
	| flow list grid |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	list := self list.
	list addChild: flow.

	grid := self grid.
	grid width: (self threeColumnWidthDepth: 3).
	grid addChild: (self leftResizer: grid).
	grid addChild: list.
	grid forceLayout.

	self assert: flow extent equals: (self threeColumnExtentDepth: 1).
	self assert: list extent equals: (self threeColumnExtentDepth: 2).
	self assert: grid extent equals: (self threeColumnExtentDepth: 3).

	^ grid
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnFlowListList [
	<gtExample>
	| flow firstList secondList |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	firstList := self list.
	firstList addChild: flow.

	secondList := self list.
	secondList width: (self threeColumnWidthDepth: 3).
	secondList addChild: (self leftResizer: secondList).
	secondList addChild: firstList.
	secondList forceLayout.

	self assert: flow extent equals: (self threeColumnExtentDepth: 1).
	self assert: firstList extent equals: (self threeColumnExtentDepth: 2).
	self assert: secondList extent equals: (self threeColumnExtentDepth: 3).

	^ secondList
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnHeight [

	^ {
		self redHeight + self redMargin height.
		self blueHeight + self blueMargin height.
		self greenHeight + self greenMargin height
	} max
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnHeightDepth: aNumber [

	^ self threeColumnHeight + ((self containerPadding * 2) * aNumber)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnWidth [

	^ {
		self redWidth + self redMargin width.
		self blueWidth + self blueMargin width.
		self greenWidth + self greenMargin width.
	} sum
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnWidthDepth: aNumber [

	^ self threeColumnWidth + ((self containerPadding * 2) * aNumber)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnExtentDepth: aNumber [

	^ (self twoColumnWidthDepth: aNumber) @ (self twoColumnHeightDepth: aNumber)
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFlow [
	<gtExample>
	| flow |

	flow := self flow.
	flow width: (self twoColumnWidthDepth: 1).
	flow addChild: (self leftResizer: flow).
	flow addChildren: { self red. self blue. self green }.
	flow forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).

	^ flow
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFlowFlowFlow [
	<gtExample>
	| firstFlow secondFlow thirdFlow |

	firstFlow := self flow.
	firstFlow addChildren: { self red. self blue. self green }.

	secondFlow := self flow.
	secondFlow addChild: firstFlow.

	thirdFlow := self flow.
	thirdFlow width: (self twoColumnWidthDepth: 3).
	thirdFlow addChild: (self leftResizer: thirdFlow).
	thirdFlow addChild: secondFlow.
	thirdFlow forceLayout.

	self assert: firstFlow extent equals: (self twoColumnExtentDepth: 1).
	self assert: secondFlow extent equals: (self twoColumnExtentDepth: 2).
	self assert: thirdFlow extent equals: (self twoColumnExtentDepth: 3).
	
	^ thirdFlow
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFlowFlowList [
	<gtExample>
	| firstFlow secondFlow list |

	firstFlow := self flow.
	firstFlow addChildren: { self red. self blue. self green }.

	secondFlow := self flow.
	secondFlow addChild: firstFlow.

	list := self list.
	list width: (self twoColumnWidthDepth: 3).
	list addChild: (self leftResizer: list).
	list addChild: secondFlow.
	list forceLayout.

	self assert: firstFlow extent equals: (self twoColumnExtentDepth: 1).
	self assert: secondFlow extent equals: (self twoColumnExtentDepth: 2).
	self assert: list extent equals: (self twoColumnExtentDepth: 3).
	
	^ list
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFlowGridGrid [
	<gtExample>
	| flow firstGrid secondGrid |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	firstGrid := self grid.
	firstGrid addChild: flow.

	secondGrid := self grid.
	secondGrid width: (self twoColumnWidthDepth: 3).
	secondGrid addChild: (self leftResizer: secondGrid).
	secondGrid addChild: firstGrid.
	secondGrid forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: firstGrid extent equals: (self twoColumnExtentDepth: 2).
	self assert: secondGrid extent equals: (self twoColumnExtentDepth: 3).
	
	^ secondGrid
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFlowGridList [
	<gtExample>
	| flow grid list |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	grid := self grid.
	grid addChild: flow.

	list := self list.
	list width: (self twoColumnWidthDepth: 3).
	list addChild: (self leftResizer: list).
	list addChild: grid.
	list forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: grid extent equals: (self twoColumnExtentDepth: 2).
	self assert: list extent equals: (self twoColumnExtentDepth: 3).
	
	^ list
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFlowList [
	<gtExample>
	| flow list |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	list := self list.
	list width: (self twoColumnWidthDepth: 2).
	list addChild: (self leftResizer: list).
	list addChild: flow.
	list forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: list extent equals: (self twoColumnExtentDepth: 2).

	^ list
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFlowListGrid [
	<gtExample>
	| flow list grid |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	list := self list.
	list addChild: flow.

	grid := self grid.
	grid width: (self twoColumnWidthDepth: 3).
	grid addChild: (self leftResizer: grid).
	grid addChild: list.
	grid forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: list extent equals: (self twoColumnExtentDepth: 2).
	self assert: grid extent equals: (self twoColumnExtentDepth: 3).
	
	^ grid
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFlowListList [
	<gtExample>
	| flow firstList secondList |

	flow := self flow.
	flow addChildren: { self red. self blue. self green }.

	firstList := self list.
	firstList addChild: flow.

	secondList := self list.
	secondList width: (self twoColumnWidthDepth: 3).
	secondList addChild: (self leftResizer: secondList).
	secondList addChild: firstList.
	secondList forceLayout.

	self assert: flow extent equals: (self twoColumnExtentDepth: 1).
	self assert: firstList extent equals: (self twoColumnExtentDepth: 2).
	self assert: secondList extent equals: (self twoColumnExtentDepth: 3).

	^ secondList
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnHeight [

	^ {
		self redHeight + self redMargin height.
		self blueHeight + self blueMargin height.
	} max + self greenHeight + self greenMargin height
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnHeightDepth: aNumber [

	^ self twoColumnHeight + ((self containerPadding * 2) * aNumber)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnWidth [

	^ {
		self redWidth + self redMargin width + self blueWidth + self blueMargin width.
		self greenWidth + self greenMargin width.
	} max
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnWidthDepth: aNumber [

	^ self twoColumnWidth + ((self containerPadding * 2) * aNumber)
]
