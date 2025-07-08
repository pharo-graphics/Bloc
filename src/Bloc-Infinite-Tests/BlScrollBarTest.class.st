Class {
	#name : #BlScrollBarTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'space',
		'largeElement',
		'scrollableElement',
		'hBar',
		'vBar',
		'scrollPane'
	],
	#category : #'Bloc-Infinite-Tests'
}

{ #category : #running }
BlScrollBarTest >> dragOn: anElement byAll: aSequenceOfDeltas [

	BlSpace simulateDragOn: anElement byAll: aSequenceOfDeltas.
	self waitTestingSpaces
]

{ #category : #running }
BlScrollBarTest >> setUp [

	| largeExtent gap |
	super setUp.

	space := self newTestingSpace.
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

	space root
		layout: BlLinearLayout new;
		padding: (BlInsets all: gap);
		background: Color green;
		addChild: scrollPane.
	space extent: 100 asPoint.
"	space show."
	self waitTestingSpaces
]

{ #category : #tests }
BlScrollBarTest >> testHorizontalDragThumbBeyondBounds [

	"Increase offset by a small distance"
	self dragOn: hBar thumb byAll: { 10 asPoint }.
	self
		assert: scrollableElement computeHorizontalScrollOffset
		equals: 25.

	"Increase offset to max offset"
	self dragOn: hBar thumb byAll: { scrollableElement extent * 2 }.
	self
		assert: scrollableElement computeHorizontalScrollOffset
		equals: 120

]

{ #category : #tests }
BlScrollBarTest >> testHorizontalDragThumbReturn [

	self
		dragOn: hBar thumb
		byAll: {
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
	self dragOn: vBar thumb byAll: { 10 asPoint }.
	self
		assert: scrollableElement computeVerticalScrollOffset
		equals: 50.

	"Increase offset to max offset"
	self dragOn: vBar thumb byAll: { scrollableElement extent * 2 }.
	self
		assert: scrollableElement computeVerticalScrollOffset
		equals: 300
]

{ #category : #tests }
BlScrollBarTest >> testVerticalDragThumbReturn [

	self
		dragOn: vBar thumb
		byAll: {
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
