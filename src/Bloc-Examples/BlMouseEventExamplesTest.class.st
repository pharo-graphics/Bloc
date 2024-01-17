Class {
	#name : 'BlMouseEventExamplesTest',
	#superclass : 'TestCase',
	#category : 'Bloc-Examples-Event',
	#package : 'Bloc-Examples',
	#tag : 'Event'
}

{ #category : 'private' }
BlMouseEventExamplesTest >> bottomLeftText: anEvent [

	self
		pointToText: (self boundsOf: anEvent currentTarget parent) bottomLeft
		for: anEvent currentTarget
]

{ #category : 'private' }
BlMouseEventExamplesTest >> bottomRightText: anEvent [

	self
		pointToText: (self boundsOf: anEvent currentTarget parent) bottomRight
		for: anEvent currentTarget
]

{ #category : 'private' }
BlMouseEventExamplesTest >> boundsOf: anElement [
	| aRoot |

	aRoot := anElement.
	anElement
		withAllParentsDo: [ :aParent | aParent userData at: #blocEvents ifPresent: [ :aName | aRoot := aParent ] ].	
	
	^ anElement bounds inParent: aRoot
]

{ #category : 'instance creation' }
BlMouseEventExamplesTest >> box [

	<sampleInstance>
	^ BlElement new
		  addChild: (self label
				   constraintsDo: [ :c |
					   c ignored horizontal alignLeft.
					   c ignored vertical alignTop ];
				   addEventHandler: (BlEventHandler
						    on: BlElementPositionInSpaceChangedEvent
						    do: [ :anEvent | self topLeftText: anEvent ]));
		  addChild: (self label
				   constraintsDo: [ :c |
					   c ignored horizontal alignRight.
					   c ignored vertical alignTop ];
				   addEventHandler: (BlEventHandler
						    on: BlElementPositionInSpaceChangedEvent
						    do: [ :anEvent | self topRightText: anEvent ]));
		  addChild: (self label
				   constraintsDo: [ :c |
					   c ignored horizontal alignLeft.
					   c ignored vertical alignBottom ];
				   addEventHandler: (BlEventHandler
						    on: BlElementPositionInSpaceChangedEvent
						    do: [ :anEvent | self bottomLeftText: anEvent ]));
		  addChild: (self label
				   constraintsDo: [ :c |
					   c ignored horizontal alignRight.
					   c ignored vertical alignBottom ];
				   addEventHandler: (BlEventHandler
						    on: BlElementPositionInSpaceChangedEvent
						    do: [ :anEvent | self bottomRightText: anEvent ]))
]

{ #category : 'instance creation' }
BlMouseEventExamplesTest >> child [

	<sampleInstance>
	^ self box
		  border: (BlBorder paint: Color red width: 1);
		  background: (Color red alpha: 0.3);
		  size: 400 @ 300
]

{ #category : 'instance creation' }
BlMouseEventExamplesTest >> grandChild [

	<sampleInstance>
	^ self box
		  border: (BlBorder paint: Color blue width: 1);
		  background: (Color blue alpha: 0.3);
		  size: 400 @ 100
]

{ #category : 'instance creation' }
BlMouseEventExamplesTest >> label [

	<sampleInstance>
	^ BlTextElement new
		  preventMeAndChildrenMouseEvents;
		  text: ((0 @ 0) asRopedText fontSize: 10);
		  padding: (BlInsets all: 2);
		  constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : 'instance creation' }
BlMouseEventExamplesTest >> parent [

	<sampleInstance>
	^ self box
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.3);
		  size: 300 @ 250;
		  in: [ :anElement |
			  anElement userData at: #blocEvents put: #parent ];
		  yourself
]

{ #category : 'private' }
BlMouseEventExamplesTest >> pointToText: aPoint for: aTextElement [
	aTextElement text: (aPoint asRopedText fontSize: 10; foreground: (aTextElement parent background paint color darker alpha: 1))
]

{ #category : 'examples - find event target' }
BlMouseEventExamplesTest >> testParentWithClip [

	<sampleInstance>
	| gray red blue |
	blue := self grandChild.
	blue position: 100 @ 50.

	red := self child.
	red position: 100 @ 100.
	red addChild: blue.

	gray := self parent.
	gray clipChildren: true.
	gray addChild: red.
	gray forceLayout.

	"on gray outside red and blue"
	self assert: (gray findMouseEventTargetAt: 50 @ 50) equals: gray.

	"on red inside gray but outside blue"
	self assert: (gray findMouseEventTargetAt: 150 @ 150) equals: red.

	"on red outside blue and gray"
	self assert: (gray findMouseEventTargetAt: 200 @ 300) equals: nil.

	"on blue inside red and gray"
	self assert: (gray findMouseEventTargetAt: 250 @ 200) equals: blue.

	"on blue inside red but outside gray"
	self assert: (gray findMouseEventTargetAt: 350 @ 200) equals: nil.

	"on blue outside red and gray"
	self assert: (gray findMouseEventTargetAt: 550 @ 200) equals: nil.

	"outside of all"
	self assert: (gray findMouseEventTargetAt: 700 @ 500) equals: nil.

	^ gray
]

{ #category : 'examples - find event target' }
BlMouseEventExamplesTest >> testParentWithoutClipChildWithClip [

	<sampleInstance>
	| gray red blue |
	blue := self grandChild.
	blue position: 100 @ 50.

	red := self child.
	red position: 100 @ 100.
	red addChild: blue.

	gray := self parent.
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
	self assert: (gray findMouseEventTargetAt: 550 @ 200) equals: nil.

	"outside of all"
	self assert: (gray findMouseEventTargetAt: 700 @ 500) equals: nil.

	^ gray
]

{ #category : 'examples - find event target' }
BlMouseEventExamplesTest >> testParentWithoutClipChildWithoutClip [

	<sampleInstance>
	| gray red blue |
	blue := self grandChild.
	blue position: 100 @ 50.

	red := self child.
	red clipChildren: false.
	red position: 100 @ 100.
	red addChild: blue.

	gray := self parent.
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
	self assert: (gray findMouseEventTargetAt: 700 @ 500) equals: nil.

	^ gray
]

{ #category : 'private' }
BlMouseEventExamplesTest >> topLeftText: anEvent [

	self
		pointToText: (self boundsOf: anEvent currentTarget parent) topLeft
		for: anEvent currentTarget
]

{ #category : 'private' }
BlMouseEventExamplesTest >> topRightText: anEvent [

	self
		pointToText: (self boundsOf: anEvent currentTarget parent) topRight
		for: anEvent currentTarget
]
