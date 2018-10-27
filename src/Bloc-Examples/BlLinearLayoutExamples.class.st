"
I contain examples of a linear layout (both horizontal and vertical).

I show how different resizing strategies work and how to use weight in order to distribute elements proportionally within parent.
"
Class {
	#name : #BlLinearLayoutExamples,
	#superclass : #TestCase,
	#category : 'Bloc-Examples-Layout'
}

{ #category : #examples }
BlLinearLayoutExamples class >> exampleHorizontalListFixedWidthLTR [
	<example>
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
		size: 450 @ 150;
		relocate: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
		
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space show
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleHorizontalListFixedWidthRTL [
	<example>
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
		size: 450 @ 150;
		relocate: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
		
	space := BlSpace new.
	space root addChild: el.
	BlElementSelection on: el.
	space show
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleHorizontalListLTR [
<example>
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
		size: 300@80;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleHorizontalListRTL [
<example>
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
		size: 300@80;
		relocate: 200 @ 100;
		background: Color veryVeryLightGray;
		addChildren: { e1. e2. e3 }.

	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleHorizontalTopCenterBottomLTR [
<example>
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
		size: 300@80;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleHorizontalTopCenterBottomRTL [
<example>
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
		size: 300@80;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleHorizontalUsingWeightLTR [
<example>
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
		size: 300@80;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.

	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleHorizontalUsingWeightRTL [
<example>
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
		size: 300@80;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: {e1. e2. e3}.

	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleVerticalLeftCenterRightLRT [
	<example>
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
		size: 50@50;
		constraintsDo: [ :c |
			c linear horizontal alignRight ];
		background: Color yellow.
	
	el := BlElement new
		layout: BlLinearLayout vertical;
		size: 200@300;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3 }.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleVerticalLeftCenterRightRTL [
	<example>
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
		size: 50@50;
		constraintsDo: [ :c |
			c linear horizontal alignRight ];
		background: Color yellow.

	el := BlElement new
		layout: BlLinearLayout vertical rightToLeft;
		size: 200@300;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3 }.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleVerticalList [
<example>
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
		size: 80@300;
		relocate: 200 @ 100;
		padding: (BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #examples }
BlLinearLayoutExamples class >> exampleVerticalListFixedHeight [
	<example>
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
		size: 80@300;
		relocate: 200 @ 100;
		padding:(BlInsets all: 10);
		background: Color blue;
		addChildren: {e1. e2. e3}.
	
	space := BlSpace new.
	space root addChild:el.
	BlElementSelection on: el.
	space show
	
]

{ #category : #'layout - examples' }
BlLinearLayoutExamples >> equalizingHeighAndWidth [
	<gtExample>	
	| parent child child2 |

	parent := BlElement new.
	parent layout: (BlLinearLayout vertical withSpaceEqualization).
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
BlLinearLayoutExamples >> equalizingWidth [
	<gtExample>		
	| parent |

	parent := self twoChildrenMatchParentInFitContent.
	parent layoutDo: [ :aLinearLayout | aLinearLayout withSpaceEqualization ].

	^ parent
]

{ #category : #'layout - examples' }
BlLinearLayoutExamples >> matchParentInFitContent [
	<gtExample>
	<description: 'If all children in the parent that fits content match parent then they should be measured with 0 size'>
	| child parent |

	child := BlElement new.
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

{ #category : #'layout - examples' }
BlLinearLayoutExamples >> matchParentInFitContentChangeBackToMatchParent [
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

{ #category : #'layout - examples' }
BlLinearLayoutExamples >> matchParentInFitContentChangeToExact [
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

{ #category : #'layout - examples' }
BlLinearLayoutExamples >> twoChildrenMatchParentInFitContent [
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
BlLinearLayoutExamples >> twoChildrenOnOppositeSidesWithSpan [
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
