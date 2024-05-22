Class {
	#name : #CrossMorph4,
	#superclass : #Morph,
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #'geometry testing' }
CrossMorph4 >> containsPoint: aPoint [

	^ (self horizontalBar containsPoint: aPoint) or: [
		  self verticalBar containsPoint: aPoint ]
]

{ #category : #accessing }
CrossMorph4 >> defaultExtent [
	^ 60@60
]

{ #category : #accessing }
CrossMorph4 >> defaultLabel [

	^ 'CrossMorph tutorial'
]

{ #category : #drawing }
CrossMorph4 >> drawOn: aCanvas [

	| topAndBottom |
	aCanvas fillRectangle: self horizontalBar color: self color.
	topAndBottom := self verticalBar areasOutside: self horizontalBar.
	topAndBottom do: [ :each |
		aCanvas fillRectangle: each color: self color ]
]

{ #category : #geometry }
CrossMorph4 >> horizontalBar [

	| crossHeight |
	crossHeight := (self height / 3.0) rounded.
	^ self bounds insetBy: 0 @ crossHeight
]

{ #category : #initialization }
CrossMorph4 >> initialize [

	super initialize.
	self extent: self defaultExtent.
	self
		on: #mouseEnter send: #processMouseEnter: to: self;
		on: #mouseDown send: #processMouseDown: to: self;
		on: #mouseLeave send: #processMouseLeave: to: self;
		on: Character arrowUp do: [ self position: self position - (0 @ 10) ];
		on: Character arrowDown do: [ self position: self position + (0 @ 10) ];
		on: Character arrowRight do: [ self position: self position + (10 @ 0) ];
		on: Character arrowLeft do: [ self position: self position - (10 @ 0) ];
		on: $d meta do: [ self position: self position + (0 @ 10) ];
		on: $- do: [ self stopStepping  ];
		on: $a meta, $b meta do: [ self startStepping "does not work here"   ].
]

{ #category : #'instance creation' }
CrossMorph4 >> open [
	<script: 'self new openInWorld'>
]

{ #category : #'event handling' }
CrossMorph4 >> processMouseDown: evt [

	evt redButtonPressed ifTrue: [ self color: (Color blue alpha: 0.3) ]. "click"
	evt yellowButtonPressed ifTrue: [ self color: Color yellow ]. "action-click"
	self changed
]

{ #category : #'event handling' }
CrossMorph4 >> processMouseEnter: evt [

	self color: (Color green alpha: 0.99).
	evt hand newKeyboardFocus: self
]

{ #category : #'event handling' }
CrossMorph4 >> processMouseLeave: evt [

	self color: (Color purple alpha: 0.99).
	evt hand releaseKeyboardFocus: self
]

{ #category : #'stepping and presenter' }
CrossMorph4 >> step [

	(self color diff: Color black) < 0.1
		ifTrue: [ self color: (Color red alpha: 0.99 )]
		ifFalse: [ self color: self color darker ]
]

{ #category : #stepping }
CrossMorph4 >> stepTime [

	^ 100
]

{ #category : #geometry }
CrossMorph4 >> verticalBar [

	| crossWidth |
	crossWidth := (self width / 3.0) rounded.
	^ self bounds insetBy: crossWidth @ 0
]
