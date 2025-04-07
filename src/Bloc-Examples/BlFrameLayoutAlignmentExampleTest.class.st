Class {
	#name : #BlFrameLayoutAlignmentExampleTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Layouts'
}

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest class >> cheatSheet [

	<script>
	| space parent |
	space := BlSpace new extent: 700 @ 700.
	parent := self new cheatSheet.
	space root layout: BlFrameLayout new.
	space root addChild: parent.
	space show
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> cheatSheet [

	<demo>
	| parent |
	parent := self parent.

	"4 corners"
	parent addChildren:
		(self childrenLeft: { 0. 0. 1. 1 } Bottom: { 0. 1. 0. 1 }).
	parent addChildren:
		(self childrenRight: { 0. 0. 1. 1 } Bottom: { 0. 1. 0. 1 }).
	parent addChildren:
		(self childrenLeft: { 0. 0. 1. 1 } Top: { 0. 1. 0. 1 }).
	parent addChildren:
		(self childrenRight: { 0. 0. 1. 1 } Top: { 0. 1. 0. 1 }).
	"4 borders"
	parent addChildren:
		(self childrenLeft: { 0.5. 0.5. 0. 1 } Bottom: { 0. 1. 0.5. 0.5 }).
	parent addChildren:
		(self childrenRight: { 0.5. 0.5. 0. 1 } Bottom: { 0. 1. 0.5. 0.5 }).
	parent addChildren:
		(self childrenLeft: { 0.5. 0.5. 0. 1 } Top: { 0. 1. 0.5. 0.5 }).
	parent addChildren:
		(self childrenRight: { 0.5. 0.5. 0. 1 } Top: { 0. 1. 0.5. 0.5 }).
	"middle"
	parent addChild: (self childLeft: 0.5 Top: 0.5).
	parent addChild: (self childLeft: 0.5 Bottom: 0.5).
	parent addChild: (self childRight: 0.5 Top: 0.5).
	parent addChild: (self childRight: 0.5 Bottom: 0.5).

	^ parent
]

{ #category : #accessing }
BlFrameLayoutAlignmentExampleTest >> child [

	^ BlElement new
		  size: 70 @ 40;
		  border: (BlBorder paint: Color black width: 1);
		  layout: BlLinearLayout vertical
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> childLeft: aLeftIndex Bottom: aBottomIndex [

	| child |
	child := self child
		         constraintsDo: [ :c |
			         c frame horizontal alignLeftAt: aLeftIndex.
			         c frame vertical alignBottomAt: aBottomIndex ];
		         yourself.

	child addChild: (self textElementWith: ('Left:' , aLeftIndex asString)).
	child addChild: (self textElementWith: ('Bottom:' , aBottomIndex asString)).

	^ child
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> childLeft: aLeftIndex Top: aTopIndex [

	| child |
	child := self child
		         constraintsDo: [ :c |
			         c frame horizontal alignLeftAt: aLeftIndex.
			         c frame vertical alignTopAt: aTopIndex ];
		         yourself.

	child addChild: (self textElementWith: 'Left:' , aLeftIndex asString).
	child addChild:
		(self textElementWith: 'Top:' , aTopIndex asString).

	^ child
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> childRight: aRightIndex Bottom: aBottomIndex [

	| child |
	child := self child
		         constraintsDo: [ :c |
			         c frame horizontal alignRightAt: aRightIndex.
			         c frame vertical alignBottomAt: aBottomIndex ];
		         yourself.

	child addChild: (self textElementWith: 'Right:' , aRightIndex asString).
	child addChild:
		(self textElementWith: 'Bottom:' , aBottomIndex asString).

	^ child
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> childRight: aRightIndex Top: aTopIndex [

	| child |
	child := self child
		         constraintsDo: [ :c |
			         c frame horizontal alignRightAt: aRightIndex.
			         c frame vertical alignTopAt: aTopIndex ];
		         yourself.

	child addChild: (self textElementWith: 'Right:' , aRightIndex asString).
	child addChild:
		(self textElementWith: 'Top:' , aTopIndex asString).

	^ child
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> childrenLeft: aLeftCollection Bottom: aBottomCollection [

	| children |
	aLeftCollection size = aBottomCollection size ifFalse: [ ^ self ].
	children := OrderedCollection new.
	aLeftCollection with: aBottomCollection do: [ :left :bottom | children add: (self childLeft: left Bottom: bottom) ].
	^ children
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> childrenLeft: aLeftCollection Top: aTopCollection [

	| children |
	aLeftCollection size = aTopCollection size ifFalse: [ ^ self ].
	children := OrderedCollection new.
	aLeftCollection
		with: aTopCollection
		do: [ :left :top | children add: (self childLeft: left Top: top) ].
	^ children
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> childrenRight: aRightCollection Bottom: aBottomCollection [

	| children |
	aRightCollection size = aBottomCollection size ifFalse: [ ^ self ].
	children := OrderedCollection new.
	aRightCollection
		with: aBottomCollection
		do: [ :right :bottom |
		children add: (self childRight: right Bottom: bottom) ].
	^ children
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> childrenRight: aRightCollection Top: aTopCollection [

	| children |
	aRightCollection size = aTopCollection size ifFalse: [ ^ self ].
	children := OrderedCollection new.
	aRightCollection with: aTopCollection do: [ :right :top |
		children add: (self childRight: right Top: top) ].
	^ children
]

{ #category : #accessing }
BlFrameLayoutAlignmentExampleTest >> parent [

	| parent line1 line2 |
	parent := BlElement new
		          background: Color lightGreen;
		          size: 500 @ 500;
		          layout: BlFrameLayout new;
		          clipChildren: false;
		          constraintsDo: [ :c |
			          c frame vertical alignCenter.
			          c frame horizontal alignCenter ];
		          yourself.

	line1 := BlElement new
		         border: (BlBorder paint: Color black width: 3);
		         geometry: BlLineGeometry new;
		         outskirts: BlOutskirts centered.
	line2 := BlElement new
		         border: (BlBorder paint: Color black width: 3);
		         geometry: BlLineGeometry new;
		         outskirts: BlOutskirts centered.
	line1 addEventHandler: (BlEventHandler
			 on: BlElementLayoutComputedEvent
			 do: [ :e |
				 line1 geometry
					 from: parent width / 2 @ 0
					 to: parent width / 2 @ parent height ]).
	line2 addEventHandler: (BlEventHandler
			 on: BlElementLayoutComputedEvent
			 do: [ :e |
				 line2 geometry
					 from: 0 @ (parent height / 2)
					 to: parent width @ (parent height / 2) ]).

	parent addChildren: {
			line1.
			line2 }.
	^ parent
]

{ #category : #'as yet unclassified' }
BlFrameLayoutAlignmentExampleTest >> textElementWith: aString [

	^ (BlTextElement new
			 labelMeasurement;
			 text: aString asRopedText;
			 padding: (BlInsets left: 3)).
]
