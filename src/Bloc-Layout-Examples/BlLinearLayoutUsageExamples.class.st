"
I contain examples of a linear layout (both horizontal and vertical).

I show how different resizing strategies work and how to use weight in order to distribute elements proportionally within parent.
"
Class {
	#name : #BlLinearLayoutUsageExamples,
	#superclass : #BlLinearLayoutExamples,
	#category : #'Bloc-Layout-Examples-LinearMigrated'
}

{ #category : #'layout - space equalization' }
BlLinearLayoutUsageExamples >> equalizingHeighAndWidth [
	<gtExample>		
	| parent |

	parent := self twoChildrenMatchParentInFitContent.
	parent layoutDo: [ :aLayout | aLayout withSpaceEqualization ].

	^ parent
]

{ #category : #'layout - space equalization' }
BlLinearLayoutUsageExamples >> equalizingWidth [
	<gtExample>		
	| parent |

	"width is by default equalized"
	parent := self twoChildrenMatchParentInFitContent.

	^ parent
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleHorizontalListFixedWidthLTR [
	<gtExample>
	| e1 e2 e3 el space |
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
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleHorizontalListFixedWidthRTL [
	<gtExample>
	| e1 e2 e3 el space |
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
		layout: (BlLinearLayout horizontal rightToLeft);
		extent: 450 @ 150;
		position: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleHorizontalListLTR [
	<gtExample>
	| e1 e2 e3 el space|
	
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
		extent: 300@80;
		position: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleHorizontalListRTL [
	<gtExample>
	| e1 e2 e3 el space|
	
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
		layout: (BlLinearLayout horizontal rightToLeft);
		extent: 300@80;
		position: 200 @ 100;
		background: Color veryVeryLightGray;
		addChildren: { e1. e2. e3 }.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleHorizontalTopCenterBottomLTR [
	<gtExample>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignTop ];
		background: Color red.

	e2 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignCenter ];
		background: Color green.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignBottom ];
		background: Color yellow.
	
	el := BlElement new
		layout: BlLinearLayout horizontal;
		extent: 300@80;
		position: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleHorizontalTopCenterBottomRTL [
	<gtExample>
	| e1 e2 e3 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignTop ];
		background: Color red.

	e2 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignCenter ];
		background: Color green.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c linear vertical alignBottom ];
		background: Color yellow.
	
	el := BlElement new
		layout: BlLinearLayout horizontal rightToLeft;
		extent: 300@80;
		position: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleHorizontalUsingWeightLTR [
	<gtExample>
	| e1 e2 e3 el space|
	
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
		extent: 300@80;
		position: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleHorizontalUsingWeightRTL [
	<gtExample>
	| e1 e2 e3 el space|
	
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
		extent: 300@80;
		position: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleVerticalLeftCenterRightLRT [
	<gtExample>
	| e1 e2 e3 el space|
	
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
		extent: 50@50;
		constraintsDo: [ :c |
			c linear horizontal alignRight ];
		background: Color yellow.
	
	el := BlElement new
		layout: BlLinearLayout vertical;
		extent: 200@300;
		position: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3 }.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleVerticalLeftCenterRightRTL [
	<gtExample>
	| e1 e2 e3 el space|
	
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
		extent: 50@50;
		constraintsDo: [ :c |
			c linear horizontal alignRight ];
		background: Color yellow.

	el := BlElement new
		layout: BlLinearLayout vertical rightToLeft;
		extent: 200@300;
		position: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3 }.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleVerticalList [
	<gtExample>
	| e1 e2 e3 el space|
	
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
		extent: 80@300;
		position: 200 @ 100;
		padding: (BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #examples }
BlLinearLayoutUsageExamples >> exampleVerticalListFixedHeight [
	<gtExample>
	| e1 e2 e3 el space|
	
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
		extent: 80@300;
		position: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	^ el
]

{ #category : #'layout - fit content' }
BlLinearLayoutUsageExamples >> matchParentInFitContent [
	<gtExample>
	<description: 'If all children in the parent that fits content match parent then they should be measured with 0 size'>
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

	self assert: parent extent equals: (300@50).
	self assert: child extent equals: (100@0).

	^ parent
]

{ #category : #'layout - fit content' }
BlLinearLayoutUsageExamples >> matchParentInFitContentChangeBackToMatchParent [
	<gtExample>
	<description: 'Changing back to match parent should reset size to 0'>
	| parent child |

	parent := self matchParentInFitContentChangeToExact.
	child := parent children first.
	child constraintsDo: [ :c | c vertical matchParent ].

	parent forceLayout.

	self assert: parent extent equals: (300@50).
	self assert: child extent equals: (100@0).

	^ parent
]

{ #category : #'layout - fit content' }
BlLinearLayoutUsageExamples >> matchParentInFitContentChangeToExact [
	<gtExample>
	<description: 'Now we change size to exact and expect parent to resize'>
	| parent child |

	parent := self matchParentInFitContent.
	child := parent children first.
	child height: 200.

	parent forceLayout.

	self assert: parent extent equals: (300@250).
	self assert: child extent equals: (100@200).

	^ parent
]

{ #category : #'layout - fit content limited' }
BlLinearLayoutUsageExamples >> oneChildWithFitContentLimited [
	<gtExample>
	| subChildren child parent |

	subChildren := 4 timesCollect: [
		BlElement new
			background: Color blue;
			margin: (BlInsets all: 10);
			extent: 200@150 ].

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

	self assert: parent extent equals: (300@400).
	self assert: child extent equals: (300@400).

	^ parent
]

{ #category : #'layout - fit content limited' }
BlLinearLayoutUsageExamples >> oneChildWithFitContentLimitedAndAnotherChild [
	<gtExample>
	| subChildren childA childB parent |

	subChildren := 4 timesCollect: [
		BlElement new
			background: Color blue;
			margin: (BlInsets all: 10);
			extent: 200@150 ].

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
	childB extent: 100@75.

	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: { childA. childB }.
	parent forceLayout. 

	self assert: parent extent equals: (300@400).
	self assert: childA extent equals: (300@325).
	self assert: childB extent equals: (100@75).

	^ parent
]

{ #category : #'layout - fit content limited' }
BlLinearLayoutUsageExamples >> oneChildWithFitContentLimitedAndAnotherChildFitContent [
	<gtExample>
	| subChildren childA childB subChildB parent |

	subChildren := 4 timesCollect: [
		BlElement new
			background: Color blue;
			margin: (BlInsets all: 10);
			extent: 200@150 ].

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
	subChildB extent: 100@75.

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
	parent addChildren: { childA. childB }.
	
	parent forceLayout. 

	self assert: parent extent equals: (300@400).
	self assert: childA extent equals: (300@325).
	self assert: childB extent equals: (300@75).
	self assert: subChildB extent equals: (100@75).

	^ parent
]

{ #category : #'layout - fit content limited' }
BlLinearLayoutUsageExamples >> oneChildWithFitContentLimitedExceedsAndThreeChildlren [
	<gtExample>
	| subChildren childA childB childC childD parent |

	subChildren := 4 timesCollect: [
		BlElement new
			background: (Color red alpha: 0.5);
			margin: (BlInsets all: 20);
			extent: 200@100 ].

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
	childB extent: 100@75.
	
	childC := BlElement new.
	childC background: (Color blue alpha: 0.3).
	childC border: (BlBorder paint: Color blue width: 2).
	childC extent: 75@50.
	
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
	parent addChildren: { childC . childA. childB . childD }.
	parent padding: (BlInsets left: 20 right: 20).
	parent forceLayout. 

	self assert: parent extent equals: (300@400).
	self assert: childA extent equals: (260@175).
	self assert: childB extent equals: (100@75).
	self assert: childC extent equals: (75@50).
	self assert: childD extent equals: (260@0).

	^ parent
]

{ #category : #'layout - fit content limited' }
BlLinearLayoutUsageExamples >> oneChildWithFitContentLimitedExceedsAndTwoChildlren [
	<gtExample>
	| subChildren childA childB childC parent |

	subChildren := 4 timesCollect: [
		BlElement new
			background: (Color red alpha: 0.5);
			margin: (BlInsets all: 20);
			extent: 200@100 ].

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
	childB extent: 100@75.
	
	childC := BlElement new.
	childC background: (Color blue alpha: 0.3).
	childC border: (BlBorder paint: Color blue width: 2).
	childC extent: 75@50.

	parent := BlElement new.
	parent layout: (BlLinearLayout vertical cellSpacing: 20).
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: { childC . childA. childB }.
	parent padding: (BlInsets left: 20 right: 20).
	parent forceLayout. 

	self assert: parent extent equals: (300@400).
	self assert: childA extent equals: (260@195).
	self assert: childB extent equals: (100@75).
	self assert: childC extent equals: (75@50).

	^ parent
]

{ #category : #'layout - fit content limited' }
BlLinearLayoutUsageExamples >> oneChildWithFitContentLimitedExceedsNotAndThreeChildlren [
	<gtExample>
	| subChildren childA childB childC childD parent |

	subChildren := 1 timesCollect: [
		BlElement new
			background: (Color red alpha: 0.5);
			margin: (BlInsets all: 20);
			extent: 200@100 ].

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
	childB extent: 100@75.
	
	childC := BlElement new.
	childC background: (Color blue alpha: 0.3).
	childC border: (BlBorder paint: Color blue width: 2).
	childC extent: 75@50.
	
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
	parent addChildren: { childC . childA. childB . childD }.
	parent padding: (BlInsets left: 20 right: 20).
	parent forceLayout. 

	self assert: parent extent equals: (300@400).
	self assert: childA extent equals: (260@140).
	self assert: childB extent equals: (100@75).
	self assert: childC extent equals: (75@50).
	self assert: childD extent equals: (260@35).

	^ parent
]

{ #category : #'layout - fit content limited' }
BlLinearLayoutUsageExamples >> oneChildWithFitContentLimitedExceedsNotAndTwoChildlren [
	<gtExample>
	| subChildren childA childB childC parent |

	subChildren := 1 timesCollect: [
		BlElement new
			background: (Color red alpha: 0.5);
			margin: (BlInsets all: 20);
			extent: 200@100 ].

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
	childB extent: 100@75.
	
	childC := BlElement new.
	childC background: (Color blue alpha: 0.3).
	childC border: (BlBorder paint: Color blue width: 2).
	childC extent: 75@50.

	parent := BlElement new.
	parent layout: (BlLinearLayout vertical cellSpacing: 20).
	parent background: (Color gray alpha: 0.3).
	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 400 ].
	parent addChildren: { childC . childA. childB }.
	parent padding: (BlInsets left: 20 right: 20).
	parent forceLayout. 

	self assert: parent extent equals: (300@400).
	self assert: childA extent equals: (260@140).
	self assert: childB extent equals: (100@75).
	self assert: childC extent equals: (75@50).

	^ parent
]

{ #category : #'layout - space equalization' }
BlLinearLayoutUsageExamples >> twoChildrenMatchParentInFitContent [
	<gtExample>	
	| parent child child2 |

	parent := BlElement new.
	parent layout: (BlLinearLayout vertical).
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

{ #category : #'layout - examples' }
BlLinearLayoutUsageExamples >> twoChildrenOnOppositeSidesWithSpan [
	<gtExample>
	| parent left span right |
	
	parent := BlElement new.
	parent background: (Color gray alpha: 0.3).
	parent layout: (BlLinearLayout horizontal).
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
	span border: (BlBorder builder dashed width: 1; paint: Color gray; build).
	span margin: (BlInsets all: 5).
	span constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent. ].

	right := BlElement new.
	right margin: (BlInsets all: 5).
	right background: (Color blue alpha: 0.3).
	right border: (BlBorder paint: Color blue width: 1).
	right constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical exact: 30.
		c linear vertical alignCenter ].

	parent addChildren: { left . span . right }.

	^ parent
]
