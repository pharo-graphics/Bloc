Class {
	#name : #BlScrollBarTest,
	#superclass : #BlSpaceTestCase,
	#instVars : [
		'largeElement',
		'scrollableElement',
		'hBar',
		'vBar',
		'scrollPane'
	],
	#category : #'Bloc-Infinite-Tests'
}

{ #category : #running }
BlScrollBarTest >> setUp [

	| largeExtent gap |
	super setUp.

	space title: testSelector asString.
	
	gap := 5.
	largeExtent := 200 @ 400.
	largeElement := BlElement new
		extent: largeExtent;
		background: (BlRadialGradientPaint new
			stops: { 0 -> Color blue. 1 -> Color red };
			innerCenter:  largeExtent // 2;
			innerRadius: 0;
			outerCenter: largeExtent //2;
			outerRadius:  largeExtent min;
			yourself);
		yourself.

	scrollableElement :=
		BlScrollableElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			addChild: largeElement;
			yourself.

	hBar :=
		BlHorizontalScrollbarElement new
			constraintsDo: [ :c |
				c ignoreByLayout.
				c ignored vertical alignBottom ];
			attachTo: scrollableElement;
			yourself.

	vBar :=
		BlVerticalScrollbarElement new
			constraintsDo: [ :c |
				c ignoreByLayout.
				c ignored horizontal alignRight ];
			attachTo: scrollableElement;
			yourself.
	
	scrollPane :=
		BlElement new
			addChild: scrollableElement;
			addChild: vBar;
			addChild: hBar;
			margin: (BlInsets all: gap);
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.

	space deferAndSettle: [
		space root
			layout: BlLinearLayout new;
			padding: (BlInsets all: gap);
			background: Color green;
			addChild: scrollPane.
		space extent: 100 asPoint ]
]

{ #category : #tests }
BlScrollBarTest >> testHorizontalDragThumbBeyondBounds [

	"Increase offset by a small distance"
	hBar thumb eventSimulator dragByAll: { 10 asPoint }.
	self
		assert: scrollableElement computeHorizontalScrollOffset
		equals: 25.

	"Increase offset to max offset"
	hBar thumb eventSimulator dragByAll: { scrollableElement extent * 2 }.
	self
		assert: scrollableElement computeHorizontalScrollOffset
		equals: 120

]

{ #category : #tests }
BlScrollBarTest >> testHorizontalDragThumbReturn [

	hBar thumb eventSimulator dragByAll: {
		scrollableElement extent * 2.
		-10 asPoint }.
	self
		assert: scrollableElement computeHorizontalScrollOffset
		equals: 120
]

{ #category : #tests }
BlScrollBarTest >> testHorizontalScrollInitialValues [

	self assert: scrollableElement computeHorizontalScrollOffset isZero.
	self
		assert: scrollableElement computeHorizontalScrollRange
		equals: largeElement extent x.
	self
		assert: scrollableElement computeHorizontalScrollExtent
		equals: scrollableElement extent x
]

{ #category : #tests }
BlScrollBarTest >> testVerticalDragThumbBeyondBounds [

	"Increase offset by a small distance"
	vBar thumb eventSimulator dragByAll: { 10 asPoint }.
	self
		assert: scrollableElement computeVerticalScrollOffset
		equals: 50.

	"Increase offset to max offset"
	vBar thumb eventSimulator dragByAll: { scrollableElement extent * 2 }.
	self
		assert: scrollableElement computeVerticalScrollOffset
		equals: 300
]

{ #category : #tests }
BlScrollBarTest >> testVerticalDragThumbReturn [

	vBar thumb eventSimulator dragByAll: {
		scrollableElement extent * 2.
		-10 asPoint }.

	self
		assert: scrollableElement computeVerticalScrollOffset
		equals: 300
]

{ #category : #tests }
BlScrollBarTest >> testVerticalScrollInitialValues [

	self assert: scrollableElement computeVerticalScrollOffset isZero.
	self
		assert: scrollableElement computeVerticalScrollRange
		equals: largeElement extent y.
	self
		assert: scrollableElement computeVerticalScrollExtent
		equals: scrollableElement extent y
]
