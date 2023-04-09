"
I contain examples of a flow layout
"
Class {
	#name : #BlFlowLayoutCompositionExamples,
	#superclass : #BlExampleTest,
	#category : #'Bloc-Layout-Examples-FlowMigrated'
}

{ #category : #examples }
BlFlowLayoutCompositionExamples class >> exampleHorizontalList [
	<gtExample>
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
		geometry: BlEllipseGeometry new;
		background: Color orange.

	el := BlElement new
		layout: BlFlowLayout new horizontal;
		size: 166@300;
		relocate: 200 @ 100;
		background: Color veryLightGray;
		border: (BlBorder paint: Color lightGray width: 8);
		padding: (BlInsets all: 8);
		addChildren: { e1. e2. e3. e4 . e5 }.
	^ el
]

{ #category : #examples }
BlFlowLayoutCompositionExamples class >> exampleText [
	<gtExample>
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
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
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
	^ aParent
]

{ #category : #examples }
BlFlowLayoutCompositionExamples class >> floatingCells [
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

{ #category : #'examples - setup' }
BlFlowLayoutCompositionExamples >> blueCell [
	<gtExample>

	^ self cell
		background: (Color blue alpha: 0.5);
		yourself
]

{ #category : #'examples - setup' }
BlFlowLayoutCompositionExamples >> cell [
	<gtExample>
	
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal exact: 50.
			c vertical exact: 25.
			c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ];
		yourself
]

{ #category : #'examples - setup' }
BlFlowLayoutCompositionExamples >> container [
	<gtExample>
	
	^ BlElement new
		layout: BlFlowLayout new horizontal;
		border: (BlBorder paint: Color lightGray width: 8);
		background: Color white darker
]

{ #category : #'examples - setup' }
BlFlowLayoutCompositionExamples >> floatBlueCell [
	<gtExample>

	^ self floatCell
		size: 50@109;
		background: Color blue
]

{ #category : #'examples - setup' }
BlFlowLayoutCompositionExamples >> floatCell [
	<gtExample>

	^ BlElement new
		constraintsDo: [ :c | 
			c flow float.
			c margin: (BlInsets top: 10 right: 0 bottom: 0 left: 10) ]
]

{ #category : #'examples - setup' }
BlFlowLayoutCompositionExamples >> floatRedCell [
	<gtExample>

	^ self floatCell
		size: 103@165;
		background: Color red
]

{ #category : #'examples - list with floats' }
BlFlowLayoutCompositionExamples >> floatingCells [
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

{ #category : #'examples - setup' }
BlFlowLayoutCompositionExamples >> grayCell [
	<gtExample>

	^ self cell
		background: Color veryLightGray;
		yourself
]

{ #category : #'examples - setup' }
BlFlowLayoutCompositionExamples >> redCell [
	<gtExample>

	^ self cell
		background: (Color red alpha: 0.5);
		yourself
]
