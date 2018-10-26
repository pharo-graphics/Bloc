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
		margin: (BlInsets all: 20);
		addChild: (self layoutLabel: 'Grid')
]

{ #category : #'private - helpers' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> layoutLabel: aString [
	^ BlTextElement new
		text: (aString asRopedText thin fontSize: 10);
		boundsBaseline;
		padding: (BlInsets top: 5);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignCenter ]
]

{ #category : #'private - helpers' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> leftResizer: anElement [
	^ BlElement new
		background: (Color gray alpha: 0.4);
		geometry: (BlRectangle cornerRadius: 3);
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

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnFitContent [
	<gtExample>
	| grid list flow |

	grid := self grid.
	grid width: self oneColumnWidthWithGrid.
	grid addChild: (self leftResizer: grid).
	
	list := self list.
	flow := self flow.

	flow addChildren: { self red. self blue. self green }.

	list addChild: flow.
	grid addChild: list.

	grid forceLayout.
	
	self assert: flow extent equals: self oneColumnWidthWithFlow @ self oneColumnHeightWithFlow.
	self assert: list extent equals: self oneColumnWidthWithList @ self oneColumnHeightWithList.
	self assert: grid extent equals: self oneColumnWidthWithGrid @ self oneColumnHeightWithGrid.
	
	^ grid
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnHeight [
	<gtExample>

	^ {
		self redHeight + self redMargin height.
		self blueHeight + self blueMargin height.
		self greenHeight + self greenMargin height.
	} sum
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnHeightWithFlow [
	<gtExample>

	^ self oneColumnHeight + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnHeightWithGrid [
	<gtExample>

	^ self oneColumnHeightWithList + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnHeightWithList [
	<gtExample>

	^ self oneColumnHeightWithFlow + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnWidth [
	<gtExample>

	^ {
		self redWidth + self redMargin width.
		self blueWidth + self blueMargin width.
		self greenWidth + self greenMargin width.
	} max
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnWidthWithFlow [
	<gtExample>

	^ self oneColumnWidth + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnWidthWithGrid [
	<gtExample>

	^ self oneColumnWidthWithList + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> oneColumnWidthWithList [
	<gtExample>

	^ self oneColumnWidthWithFlow + (self containerPadding * 2)
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

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnFitContent [
	<gtExample>
	| grid list flow |

	grid := self grid.
	"pixel perfect layout precision required for this to work.
	if the width would be 1pt smaller, then the flow layout will wrap and fallback to 2 columns"
	grid width: self threeColumnWidthWithGrid.
	grid addChild: (self leftResizer: grid).
	
	list := self list.
	flow := self flow.

	flow addChildren: { self red. self blue. self green }.

	list addChild: flow.
	grid addChild: list.

	grid forceLayout.
	
	self assert: flow extent equals: self threeColumnWidthWithFlow @ self threeColumnHeightWithFlow.
	self assert: list extent equals: self threeColumnWidthWithList @ self threeColumnHeightWithList.
	self assert: grid extent equals: self threeColumnWidthWithGrid @ self threeColumnHeightWithGrid.

	^ grid
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnHeight [
	<gtExample>

	^ {
		self redHeight + self redMargin height.
		self blueHeight + self blueMargin height.
		self greenHeight + self greenMargin height
	} max
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnHeightWithFlow [
	<gtExample>

	^ self threeColumnHeight + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnHeightWithGrid [
	<gtExample>

	^ self threeColumnHeightWithList + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnHeightWithList [
	<gtExample>

	^ self threeColumnHeightWithFlow + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnWidth [
	<gtExample>

	^ {
		self redWidth + self redMargin width.
		self blueWidth + self blueMargin width.
		self greenWidth + self greenMargin width.
	} sum
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnWidthWithFlow [
	<gtExample>

	^ self threeColumnWidth + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnWidthWithGrid [
	<gtExample>

	^ self threeColumnWidthWithList + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> threeColumnWidthWithList [
	<gtExample>

	^ self threeColumnWidthWithFlow + (self containerPadding * 2)
]

{ #category : #examples }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnFitContent [
	<gtExample>
	| grid list flow  |

	grid := self grid.

	"pixel perfect layout precision required for this to work.
	if the width would be 1pt smaller, then the flow layout will wrap and fallback to 1 column"
	grid width: self twoColumnWidthWithGrid.
	grid addChild: (self leftResizer: grid).
	
	list := self list.
	flow := self flow.

	flow addChildren: { self red. self blue. self green }.

	list addChild: flow.
	grid addChild: list.

	grid forceLayout.
	
	self assert: flow extent equals: self twoColumnWidthWithFlow @ self twoColumnHeightWithFlow.
	self assert: list extent equals: self twoColumnWidthWithList @ self twoColumnHeightWithList.
	self assert: grid extent equals: self twoColumnWidthWithGrid @ self twoColumnHeightWithGrid.
	
	^ grid
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnHeight [
	<gtExample>

	^ {
		self redHeight + self redMargin height.
		self blueHeight + self blueMargin height.
	} max + self greenHeight + self greenMargin height
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnHeightWithFlow [
	<gtExample>

	^ self twoColumnHeight + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnHeightWithGrid [
	<gtExample>

	^ self twoColumnHeightWithList + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnHeightWithList [
	<gtExample>

	^ self twoColumnHeightWithFlow + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnWidth [
	<gtExample>

	^ {
		self redWidth + self redMargin width + self blueWidth + self blueMargin width.
		self greenWidth + self greenMargin width.
	} max
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnWidthWithFlow [
	<gtExample>

	^ self twoColumnWidth + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnWidthWithGrid [
	<gtExample>

	^ self twoColumnWidthWithList + (self containerPadding * 2)
]

{ #category : #'private - measurement' }
BlFitContentVerticallyInHorizontalLayoutsExamples >> twoColumnWidthWithList [
	<gtExample>

	^ self twoColumnWidthWithFlow + (self containerPadding * 2)
]
