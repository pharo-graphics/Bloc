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
		background: (BlBackground paint: Color blue);
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
		background: (BlBackground paint: Color blue);
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
