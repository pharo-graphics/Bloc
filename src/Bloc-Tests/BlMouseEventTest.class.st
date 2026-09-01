Class {
	#name : #BlMouseEventTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Events'
}

{ #category : #running }
BlMouseEventTest >> bottomLeftText: anEvent [

	self
		pointToText: (self boundsOf: anEvent currentTarget parent) bottomLeft
		for: anEvent currentTarget
]

{ #category : #running }
BlMouseEventTest >> bottomRightText: anEvent [

	self
		pointToText: (self boundsOf: anEvent currentTarget parent) bottomRight
		for: anEvent currentTarget
]

{ #category : #running }
BlMouseEventTest >> boundsOf: anElement [

	| aRoot |
	aRoot := anElement.
	anElement withAllParentsDo: [ :aParent |
		aParent userData
			at: #blocEvents
			ifPresent: [ :aName | aRoot := aParent ] ].

	^ anElement bounds inParent: aRoot
]

{ #category : #'running - instance creation' }
BlMouseEventTest >> newBox [

	^ BlElement new
		  addChild: (self newLabel
				   constraintsDo: [ :c |
					   c ignored horizontal alignLeft.
					   c ignored vertical alignTop ];
				   addEventHandler: (BlEventHandler
						    on: BlElementPositionInSpaceChangedEvent
						    do: [ :anEvent | self topLeftText: anEvent ]));
		  addChild: (self newLabel
				   constraintsDo: [ :c |
					   c ignored horizontal alignRight.
					   c ignored vertical alignTop ];
				   addEventHandler: (BlEventHandler
						    on: BlElementPositionInSpaceChangedEvent
						    do: [ :anEvent | self topRightText: anEvent ]));
		  addChild: (self newLabel
				   constraintsDo: [ :c |
					   c ignored horizontal alignLeft.
					   c ignored vertical alignBottom ];
				   addEventHandler: (BlEventHandler
						    on: BlElementPositionInSpaceChangedEvent
						    do: [ :anEvent | self bottomLeftText: anEvent ]));
		  addChild: (self newLabel
				   constraintsDo: [ :c |
					   c ignored horizontal alignRight.
					   c ignored vertical alignBottom ];
				   addEventHandler: (BlEventHandler
						    on: BlElementPositionInSpaceChangedEvent
						    do: [ :anEvent | self bottomRightText: anEvent ]));
		  yourself
]

{ #category : #'running - instance creation' }
BlMouseEventTest >> newChild [

	^ self newBox
		  border: (BlBorder paint: Color red width: 1);
		  background: (Color red alpha: 0.3);
		  extent: 400 @ 300;
		  yourself
]

{ #category : #'running - instance creation' }
BlMouseEventTest >> newGrandChild [

	^ self newBox
		  border: (BlBorder paint: Color blue width: 1);
		  background: (Color blue alpha: 0.3);
		  extent: 400 @ 100;
		  yourself
]

{ #category : #'running - instance creation' }
BlMouseEventTest >> newLabel [

	^ BlTextElement new
		  preventMeAndChildrenMouseEvents;
		  text: ((0 @ 0) asRopedText fontSize: 10);
		  padding: (BlInsets all: 2);
		  constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : #'running - instance creation' }
BlMouseEventTest >> newParent [

	^ self newBox
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.3);
		  extent: 300 @ 250;
		  in: [ :anElement |
			  anElement userData at: #blocEvents put: #parent ];
		  yourself
]

{ #category : #running }
BlMouseEventTest >> pointToText: aPoint for: aTextElement [

	aTextElement text: 
		(aPoint asRopedText
			 fontSize: 10;
			 foreground: (aTextElement parent background paint color darker alpha: 1);
			 yourself)
]

{ #category : #tests }
BlMouseEventTest >> testParentWithClip [

	| gray red blue |
	blue := self newGrandChild.
	blue position: 100 @ 50.

	red := self newChild.
	red position: 100 @ 100.
	red addChild: blue.

	gray := self newParent.
	gray clipChildren: true.
	gray addChild: red.
	gray forceLayout.

	"on gray outside red and blue"
	self assert: (gray findMouseEventTargetAt: 50 @ 50) equals: gray.

	"on red inside gray but outside blue"
	self assert: (gray findMouseEventTargetAt: 150 @ 150) equals: red.

	"on red outside blue and gray"
	self assert: (gray findMouseEventTargetAt: 200 @ 300) isNil.

	"on blue inside red and gray"
	self assert: (gray findMouseEventTargetAt: 250 @ 200) equals: blue.

	"on blue inside red but outside gray"
	self assert: (gray findMouseEventTargetAt: 350 @ 200) isNil.

	"on blue outside red and gray"
	self assert: (gray findMouseEventTargetAt: 550 @ 200) isNil.

	"outside of all"
	self assert: (gray findMouseEventTargetAt: 700 @ 500) isNil
]

{ #category : #tests }
BlMouseEventTest >> testParentWithoutClipChildWithClip [

	| gray red blue |
	blue := self newGrandChild.
	blue position: 100 @ 50.

	red := self newChild.
	red position: 100 @ 100.
	red addChild: blue.

	gray := self newParent.
	gray clipChildren: false.
	gray addChild: red.
	gray forceLayout.

	"on gray outside red and blue"
	self assert: (gray findMouseEventTargetAt: 50 @ 50) equals: gray.

	"on red inside gray but outside blue"
	self assert: (gray findMouseEventTargetAt: 150 @ 150) equals: red.

	"on red outside blue and gray"
	self assert: (gray findMouseEventTargetAt: 200 @ 300) equals: red.

	"on blue inside red and gray"
	self assert: (gray findMouseEventTargetAt: 250 @ 200) equals: blue.

	"on blue inside red but outside gray"
	self assert: (gray findMouseEventTargetAt: 350 @ 200) equals: blue.

	"on blue outside red and gray"
	self assert: (gray findMouseEventTargetAt: 550 @ 200) isNil.

	"outside of all"
	self assert: (gray findMouseEventTargetAt: 700 @ 500) isNil
]

{ #category : #tests }
BlMouseEventTest >> testParentWithoutClipChildWithoutClip [

	| gray red blue |
	blue := self newGrandChild.
	blue position: 100 @ 50.

	red := self newChild.
	red clipChildren: false.
	red position: 100 @ 100.
	red addChild: blue.

	gray := self newParent.
	gray clipChildren: false.
	gray addChild: red.
	gray forceLayout.

	"on gray outside red and blue"
	self assert: (gray findMouseEventTargetAt: 50 @ 50) equals: gray.

	"on red inside gray but outside blue"
	self assert: (gray findMouseEventTargetAt: 150 @ 150) equals: red.

	"on red outside blue and gray"
	self assert: (gray findMouseEventTargetAt: 200 @ 300) equals: red.

	"on blue inside red and gray"
	self assert: (gray findMouseEventTargetAt: 250 @ 200) equals: blue.

	"on blue inside red but outside gray"
	self assert: (gray findMouseEventTargetAt: 350 @ 200) equals: blue.

	"on blue outside red and gray"
	self assert: (gray findMouseEventTargetAt: 550 @ 200) equals: blue.

	"outside of all"
	self assert: (gray findMouseEventTargetAt: 700 @ 500) isNil
]

{ #category : #running }
BlMouseEventTest >> topLeftText: anEvent [

	self
		pointToText: (self boundsOf: anEvent currentTarget parent) topLeft
		for: anEvent currentTarget
]

{ #category : #running }
BlMouseEventTest >> topRightText: anEvent [

	self
		pointToText: (self boundsOf: anEvent currentTarget parent) topRight
		for: anEvent currentTarget
]
