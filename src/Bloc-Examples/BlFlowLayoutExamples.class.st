"
I contain examples of a flow layout
"
Class {
	#name : #BlFlowLayoutExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Layout'
}

{ #category : #examples }
BlFlowLayoutExamples class >> exampleHorizontalList [
	<example>
	| e1 e2 e3 e4 el space e5 |

	e1 := BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 50.
			c vertical exact: 150 ];
		background: Color red.

	e2 := BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 100.
			c vertical exact: 50 ];
		background: Color green.
	
	e3 := BlElement new
		size: 50 asPoint;
		background: Color yellow.

	e4 := BlElement new
		size: 50 asPoint;
		background: Color magenta.
	
	e5 := BlElement new
		size: 50 asPoint;
		geometry: BlEllipse new;
		background: Color orange.

	el := BlElement new
		layout: BlFlowLayout new horizontal;
		size: 166@300;
		relocate: 200 @ 100;
		background: Color veryLightGray;
		border: (BlBorder paint: Color lightGray width: 8);
		padding: (BlInsets all: 8);
		addChildren: { e1. e2. e3. e4 . e5 }.

	space := BlSpace new.
	space root addChild:el.
	space root addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show
]

{ #category : #examples }
BlFlowLayoutExamples class >> exampleText [
	<example>
	| aText aLineIterator  theWords aParent aSpace floatA aFloatIndex |

	theWords := OrderedCollection new.

	aText := (String loremIpsum: 2000) asRopedText fontSize: 15.
	aLineIterator := aText iterator.

	[ aLineIterator hasNext ] whileTrue: [ 
		| aLine aWordIterator aBreak |
		aLine := aLineIterator nextLine.
		aWordIterator := aLine iterator.
		aBreak := true.
		[ aWordIterator hasNext ] whileTrue: [ 
			| aWord |
			aWord := aWordIterator nextWord.
			theWords add: (BlTextElement new
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent.
					c flow newLine: aBreak ];
				text: aWord;
				yourself).
			aBreak := false ] ].

	floatA := BlElement new
		geometry: (BlRectangle cornerRadius: 5);
		constraintsDo: [ :c | 
			c flow float.
			c horizontal exact: 63.
			c vertical exact: 155.
			c margin: (BlInsets top: 3 right: 3 bottom: 0 left: 3) ];
		background: Color red.

	aFloatIndex := (theWords size / 3) asInteger.
	
	theWords add: floatA afterIndex: aFloatIndex.
	aFloatIndex + 2 to: theWords size do: [ :anIndex |
		| anElement |
		anElement := (theWords at: anIndex).
		anElement text attributes: { BlTextForegroundAttribute paint: (Color red) }.
		anElement text: anElement text ].
	
	aParent := BlElement new
		layout: BlFlowLayout new horizontal;
		constraintsDo: [ :c |
			c horizontal exact: 600.
			c vertical fitContent.
			c padding: (BlInsets all: 10) ];
		relocate: 100 @ 50;
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color lightGray width: 8);
		addChildren: theWords;
		yourself.

	aSpace := BlSpace new.
	aSpace root addChild: aParent.
	
	aSpace root addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	aSpace show
]

{ #category : #examples }
BlFlowLayoutExamples class >> floatingCells [
	| aSpace |
	<script: 'self floatingCells'>

	aSpace := BlSpace new.
	aSpace root addChild: self new floatingCells.
	aSpace root addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	aSpace show
]

{ #category : #'instance creation' }
BlFlowLayoutExamples >> blueCell [
	<gtExample>

	^ self cell
		background: (Color blue alpha: 0.5);
		yourself
]

{ #category : #'instance creation' }
BlFlowLayoutExamples >> cell [
	<gtExample>
	
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 50.
			c vertical exact: 25.
			c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ];
		yourself
]

{ #category : #'instance creation' }
BlFlowLayoutExamples >> container [
	<gtExample>
	
	^ BlElement new
		layout: BlFlowLayout new horizontal;
		border: (BlBorder paint: Color lightGray width: 8);
		background: Color white darker
]

{ #category : #'instance creation' }
BlFlowLayoutExamples >> floatBlueCell [
	<gtExample>

	^ self floatCell
		size: 50@109;
		background: Color blue
]

{ #category : #'instance creation' }
BlFlowLayoutExamples >> floatCell [
	<gtExample>

	^ BlElement new
		constraintsDo: [ :c | 
			c flow float.
			c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ]
]

{ #category : #'instance creation' }
BlFlowLayoutExamples >> floatRedCell [
	<gtExample>

	^ self floatCell
		size: 103@165;
		background: Color red
]

{ #category : #'examples - list with floats' }
BlFlowLayoutExamples >> floatingCells [
	<gtExample>
	
	^ self container
		size: 560@400;
		relocate: 100 @ 50;
		addChildren: (2 timesCollect: [ self grayCell ]);
		addChild: self floatRedCell;
		addChildren: (30 timesCollect: [ self redCell ]);
		addChild: self floatBlueCell;
		addChildren: (4 timesCollect: [ self blueCell ]);
		yourself
]

{ #category : #'instance creation' }
BlFlowLayoutExamples >> grayCell [
	<gtExample>

	^ self cell
		background: Color veryLightGray;
		yourself
]

{ #category : #'instance creation' }
BlFlowLayoutExamples >> redCell [
	<gtExample>

	^ self cell
		background: (Color red alpha: 0.5);
		yourself
]
