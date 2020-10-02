"
I contain examples of a grid layout

I show how different resizing strategies work and how to build advanced layouts with the help of a grid
"
Class {
	#name : #BlGridLayoutUsageExplanation,
	#superclass : #Object,
	#category : #'Bloc-Examples-! Documentation - Layouts'
}

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleDistributed2x2Grid [
	<gtExample>
	| e1 e2 e3 e4 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color pink.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color green.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color red.
	
	e4 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color yellow.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		size: 300@300;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3. e4 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleDistributedWithSpan2x2Grid [
	<gtExample>
	| e1 e2 e3 el space|

	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c grid vertical span: 2 ];
		background: Color yellow.

	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c grid horizontal weight: 2 ];
		background: Color green.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c grid vertical weight: 0.5 ];
		background: Color red.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		size: 300@300;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleDistributedWithWeight2x2Grid [
	<gtExample>
	| e1 e2 e3 e4 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c grid horizontal weight: 2 ];
		background: Color pink.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color green.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color red.
	
	e4 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c grid vertical weight: 2 ];
		background: Color yellow.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		size: 300@300;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3. e4 };
		yourself.
	^ el	
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleHorizontal2x1Grid [
	<gtExample>
	| e1 e2 el space|
	
	e1 := BlElement new
		size: 150 asPoint;
		background: Color red.
	
	e2 := BlElement new
		size: 150 asPoint;
		background: Color yellow.

	el := BlElement new
		layout: BlGridLayout horizontal;
		size: 400@400;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleHorizontalSpacing2x1Grid [
	<gtExample>
	| e1 e2 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color red.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color yellow.

	el := BlElement new
		layout: (BlGridLayout horizontal cellSpacing: 20);
		size: 400@200;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleInCellAlignment2x2Grid [
	<gtExample>
	| e1 e2 e3 el space|

	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 100.
			c vertical matchParent.
			c grid vertical span: 2 ];
		background: Color yellow.

	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 100.
			c vertical exact: 50.
			c grid horizontal alignCenter ];
		background: Color green.

	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 100.
			c grid vertical alignBottom.
			c grid horizontal weight: 2 ];
		background: Color red.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		size: 300@300;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleNautilusGrid [
	<gtExample>
	| e1 e2 e3 e4 e5 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white.
	
	e3 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white.
	
	e4 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color white.

	e5 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c grid horizontal span: 4 ];
		background: Color white.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 4; cellSpacing: 10);
		size: 300@300;
		relocate: 200 @ 100;
		background: Color veryLightGray;
		addChildren: { e1. e2. e3. e4. e5 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleSimple2x2Grid [
	<gtExample>
	| e1 e2 e3 e4 el space|
	
	e1 := BlElement new
		size: 150 asPoint;
		background: Color pink.
	
	e2 := BlElement new
		size: 150 asPoint;
		background: Color green.
	
	e3 := BlElement new
		size: 150 asPoint;
		background: Color red.
	
	e4 := BlElement new
		size: 150 asPoint;
		background: Color yellow.
	
	el := BlElement new
		layout: (BlGridLayout new columnCount: 2);
		size: 400@400;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2. e3. e4 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleSpacing9x9Grid [
	<gtExample>
	| children el space dim |
	
	dim := 9.
	
	children := (1 to: (dim raisedTo: 2)) collect: [ :i |
		BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent.
				c grid ];
			background: Color random muchLighter;
			yourself ].

	el := BlElement new
		layout: (BlGridLayout new columnCount: dim; rowCount: dim; yourself);
		constraintsDo: [ :c |
			c horizontal exact: 400.
			c vertical exact: 400 ];
		relocate: 0 @ 0;
		background: Color blue;
		addChildren: children;
		yourself.
	^ el 
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleVertical1x2Grid [
	<gtExample>
	| e1 e2 el space|
	
	e1 := BlElement new
		size: 150 asPoint;
		background: Color red.
	
	e2 := BlElement new
		size: 150 asPoint;
		background: Color yellow.

	el := BlElement new
		layout: BlGridLayout vertical;
		size: 400@400;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> exampleVerticalSpacing1x2Grid [
	<gtExample>
	| e1 e2 el space|
	
	e1 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color red.
	
	e2 := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: Color yellow.

	el := BlElement new
		layout: (BlGridLayout vertical cellSpacing: 20);
		size: 200@400;
		relocate: 200 @ 100;
		background: Color blue;
		addChildren: { e1. e2 };
		yourself.
	^ el
]

{ #category : #examples }
BlGridLayoutUsageExplanation >> verticalSpan [
	<gtExample>
	| grid child1 child2 child3 |

	grid := BlElement new.
	grid size: 500@400.
	grid layout: (BlGridLayout horizontal cellSpacing: 10; columnCount: 2).

	child1 := BlElement new.
	child1 background: (Color red alpha: 0.5).
	child1 constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	child2 := BlElement new.
	child2 background: (Color blue alpha: 0.5).
	child2 constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		c grid vertical span: 2 ].

	child3 := BlElement new.
	child3 background: (Color green alpha: 0.5).
	child3 constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	grid addChildren: { child1. child2. child3 }.

	grid forceLayout.
	self assert: grid extent equals: 500@400.
	self assert: child1 position equals: 10@10.
	self assert: child1 extent equals: 235@185.
	
	self assert: child2 position equals: 255@10.
	self assert: child2 extent equals: 235@380.
	
	self assert: child3 position equals: 10@205.
	self assert: child3 extent equals: 235@185.

	^ grid
]
