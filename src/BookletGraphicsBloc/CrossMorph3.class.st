Class {
	#name : #CrossMorph3,
	#superclass : #Morph,
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #keymapping }
CrossMorph3 class >> buildShortCutsOn: aBuilder [
	<keymap>
	(aBuilder shortcut: #moveUp)
		category: #CrossMorphShortcuts
		default: Character arrowUp
		do: [ :target | target position: target position - (0 @ 10)	]
		description: 'move morph up'.

	(aBuilder shortcut: #moveDown)
		category: #CrossMorphShortcuts
		default: Character arrowDown
		do: [ :target | target position: target position + (0 @ 10)	]
		description: 'move morph down'.

	(aBuilder shortcut: #moveRight)
		category: #CrossMorphShortcuts
		default: Character arrowRight
		do: [ :target | target position: target position + (10 @ 0)	]
		description: 'move morph right'.

	(aBuilder shortcut: #moveLeft)
		category: #CrossMorphShortcuts
		default: Character arrowLeft
		do: [ :target | target position: target position - (10 @ 0) 	]
		description: 'move morph left'.

	(aBuilder shortcut: #moveDown2)
		category: #CrossMorphShortcuts
		default: $d meta
		do: [ :target | target position: target position + (0 @ 10)]
		description: 'move morph down'
]

{ #category : #'class initialization' }
CrossMorph3 class >> initialize [ 
	self buildShortCutsOn: KMBuilder keymap  
]

{ #category : #'geometry testing' }
CrossMorph3 >> containsPoint: aPoint [

	^ (self horizontalBar containsPoint: aPoint) or: [
		  self verticalBar containsPoint: aPoint ]
]

{ #category : #accessing }
CrossMorph3 >> defaultExtent [
	^ 60@60
]

{ #category : #accessing }
CrossMorph3 >> defaultLabel [

	^ 'CrossMorph tutorial'
]

{ #category : #drawing }
CrossMorph3 >> drawOn: aCanvas [

	| topAndBottom |
	aCanvas fillRectangle: self horizontalBar color: self color.
	topAndBottom := self verticalBar areasOutside: self horizontalBar.
	topAndBottom do: [ :each |
		aCanvas fillRectangle: each color: self color ]
]

{ #category : #geometry }
CrossMorph3 >> horizontalBar [

	| crossHeight |
	crossHeight := (self height / 3.0) rounded.
	^ self bounds insetBy: 0 @ crossHeight
]

{ #category : #initialization }
CrossMorph3 >> initialize [

	super initialize.
	self extent: self defaultExtent.
	self
		on: #mouseEnter send: #processMouseEnter: to: self;
		on: #mouseDown send: #processMouseDown: to: self;
		on: #mouseLeave send: #processMouseLeave: to: self;
		on: #keyStroke send: #processKeyStroke: to: self
]

{ #category : #keymapping }
CrossMorph3 >> initializeShortcuts: aKMDispatcher [
	"Where we may attach keymaps or even on:do: local shortcuts if needed."
	super initializeShortcuts: aKMDispatcher.
	aKMDispatcher attachCategory: #CrossMorphShortcuts
]

{ #category : #'instance creation' }
CrossMorph3 >> open [
	<script: 'self new openInWorld'>
]

{ #category : #'event handling' }
CrossMorph3 >> processKeyStroke: anEvent [

	| keyValue |
	keyValue := anEvent keyCharacter.
	keyValue == $+ ifTrue: [ self startStepping ].
	keyValue == $- ifTrue: [ self stopStepping ]
]

{ #category : #'event handling' }
CrossMorph3 >> processMouseDown: evt [

	evt redButtonPressed ifTrue: [ self color: (Color blue alpha: 0.3) ]. "click"
	evt yellowButtonPressed ifTrue: [ self color: Color yellow ]. "action-click"
	self changed
]

{ #category : #'event handling' }
CrossMorph3 >> processMouseEnter: evt [

	self color: (Color green alpha: 0.99).
	evt hand newKeyboardFocus: self
]

{ #category : #'event handling' }
CrossMorph3 >> processMouseLeave: evt [

	self color: (Color purple alpha: 0.99).
	evt hand releaseKeyboardFocus: self
]

{ #category : #'stepping and presenter' }
CrossMorph3 >> step [

	(self color diff: Color black) < 0.1
		ifTrue: [ self color: (Color red alpha: 0.99 )]
		ifFalse: [ self color: self color darker ]
]

{ #category : #stepping }
CrossMorph3 >> stepTime [

	^ 100
]

{ #category : #geometry }
CrossMorph3 >> verticalBar [

	| crossWidth |
	crossWidth := (self width / 3.0) rounded.
	^ self bounds insetBy: crossWidth @ 0
]
