"
A die example ported from Morphic to pharo, and used in Pharo by example book
"
Class {
	#name : #BlDie,
	#superclass : #BlElement,
	#instVars : [
		'faces',
		'dieValue',
		'animation'
	],
	#category : #'BookletGraphicsBloc-Bloc'
}

{ #category : #accessing }
BlDie class >> faces: aNumber [

	^ self new faces: aNumber
]

{ #category : #accessing }
BlDie >> dieValue: aNumber [

	((aNumber isInteger and: [ aNumber > 0 ]) and: [ aNumber <= faces ])
		ifFalse: [ ^ self ].
	dieValue := aNumber.
	self removeChildren.
	self drawPoints
]

{ #category : #drawing }
BlDie >> drawPointAt: aPoint [

	| element  x y|
	x := self extent / 6.
	y := self extent  / 6.

	element := BlElement new
		           geometry: BlCircleGeometry new;
		           size: x @ y ;
		           background: Color black;
		           position: (self extent * aPoint) - ((x/2)@(y/2)).
	self addChild: element.
]

{ #category : #drawing }
BlDie >> drawPoints [

	(self perform: ('face' , dieValue asString) asSymbol) do: [ :aPoint |
		self drawPointAt: aPoint ]
]

{ #category : #geometry }
BlDie >> face1 [

	^ { (0.5 @ 0.5) }
]

{ #category : #geometry }
BlDie >> face2 [

	^ {
		  (0.25 @ 0.25).
		  (0.75 @ 0.75) }
]

{ #category : #geometry }
BlDie >> face3 [

	^ {
		  (0.25 @ 0.25).
		  (0.75 @ 0.75).
		  (0.5 @ 0.5) }
]

{ #category : #geometry }
BlDie >> face4 [

	^ {
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75) }
]

{ #category : #geometry }
BlDie >> face5 [

	^ {
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		(0.5) @ 0.5 }
]

{ #category : #geometry }
BlDie >> face6 [

	^ {
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.25 @ 0.5).
		  (0.75 @ 0.5) } 
]

{ #category : #geometry }
BlDie >> face7 [

	^ {
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.25 @ 0.5).
		  (0.75 @ 0.5).
		  (0.5 @ 0.5) }
]

{ #category : #geometry }
BlDie >> face8 [

	^ {
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.25 @ 0.5).
		  (0.75 @ 0.5).
		  (0.5 @ 0.5).
		0.5@0.25 }
]

{ #category : #geometry }
BlDie >> face9 [

	^ {
		  (0.25 @ 0.25).
		  (0.75 @ 0.25).
		  (0.75 @ 0.75).
		  (0.25 @ 0.75).
		  (0.25 @ 0.5).
		  (0.75 @ 0.5).
		  (0.5 @ 0.5).
		  (0.5 @ 0.25).
		  (0.5 @ 0.75) }
]

{ #category : #accessing }
BlDie >> faces: aNumber [
	" Set the number of faces"

	((aNumber isInteger and: [ aNumber > 0 ]) and: [ aNumber <= 9 ])
		ifTrue: [ faces := aNumber ]
]

{ #category : #initialization }
BlDie >> initialize [

	super initialize.

	dieValue := 1.
	faces := 6.

	self
		size: 150 @ 150;
		position: 100@100;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		border: (BlBorder paint: Color black width: 2);
		background: ((BlLinearGradientPaint direction: 1 @ 1)
				 from: Color green
				 to: Color lightGreen).
				
	self whenLayoutedDoOnce:  [ self drawPoints].

	animation := BlAnimation new
		             beInfinite;
		             duration: 1 seconds.

	animation addEventHandler: (BlEventHandler
			 on: BlAnimationLoopDoneEvent
			 do: [ :anEvent | self inform: 'loop done'. self dieValue: (1 to: faces) atRandom ]).

	self addEventHandler: (BlEventHandler
			 on: BlClickEvent 
			 do: [ :anEvent |
				 animation isRunning
					 ifTrue: [
						self inform: 'stop'.
						 animation stop. ]
					 ifFalse: [
						self inform: 'start'.
						animation reset; start; setNew; enqueue ] ]).

	self addAnimation: animation
]

{ #category : #'instance creation' }
BlDie >> open [
	<demo>
	<script: '(self new faces:9) openInNewSpace'>
]
