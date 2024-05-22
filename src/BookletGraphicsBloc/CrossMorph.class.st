"
CrossMorph example taken from Pharo by example book
"
Class {
	#name : #CrossMorph,
	#superclass : #Morph,
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #testing }
CrossMorph >> containsPoint: aPoint [

	^ (self horizontalBar containsPoint: aPoint) or: [ 
		  self verticalBar containsPoint: aPoint ]
]

{ #category : #accessing }
CrossMorph >> defaultExtent [
	^ 60@60
]

{ #category : #accessing }
CrossMorph >> defaultLabel [

	^ 'CrossMorph tutorial'
]

{ #category : #drawing }
CrossMorph >> drawOn: aCanvas [

	| topAndBottom |
	aCanvas fillRectangle: self horizontalBar color: self color.
	topAndBottom := self verticalBar areasOutside: self horizontalBar.
	topAndBottom do: [ :each | 
		aCanvas fillRectangle: each color: self color ]
]

{ #category : #'event handling' }
CrossMorph >> handlesKeyDown:  evt [

	^ true
]

{ #category : #'event handling' }
CrossMorph >> handlesKeyStroke:  evt [

	^ true
]

{ #category : #'event handling' }
CrossMorph >> handlesMouseDown: evt [

	^ true
]

{ #category : #'event handling' }
CrossMorph >> handlesMouseOver: evt [

	^ true
]

{ #category : #geometry }
CrossMorph >> horizontalBar [

	| crossHeight |
	crossHeight := (self height / 3.0) rounded.
	^ self bounds insetBy: 0 @ crossHeight
]

{ #category : #initialization }
CrossMorph >> initialize [
	super initialize.
	self extent: self defaultExtent.
]

{ #category : #'event handling' }
CrossMorph >> keyDown: anEvent [

	| key |
	key := anEvent key.
	key = KeyboardKey up ifTrue: [ 
		self position: self position - (0 @ 10) ].
	key = KeyboardKey down ifTrue: [ 
		self position: self position + (0 @ 10) ].
	key = KeyboardKey right ifTrue: [ 
		self position: self position + (10 @ 0) ].
	key = KeyboardKey left ifTrue: [ 
		self position: self position - (10 @ 0) ].

	anEvent controlKeyPressed ifTrue: [ 
		anEvent keyCharacter == $d ifTrue: [ 
			self position: self position + (0 @ 10) ] ]
]

{ #category : #'event handling' }
CrossMorph >> keyStroke: anEvent [

	| keyValue |
	keyValue := anEvent keyCharacter.
	keyValue == $+ ifTrue: [ self startStepping ].
	keyValue == $- ifTrue: [ self stopStepping ]
]

{ #category : #'event handling' }
CrossMorph >> mouseDown: evt [

	evt redButtonPressed ifTrue: [ self color: (Color blue alpha: 0.3) ]. "click"
	evt yellowButtonPressed ifTrue: [ self color: Color yellow ]. "action-click"
	self changed
]

{ #category : #'event handling' }
CrossMorph >> mouseEnter: evt [

	self color: (Color green alpha: 0.99).
	evt hand newKeyboardFocus: self
]

{ #category : #'event handling' }
CrossMorph >> mouseLeave: evt [

	self color: (Color purple alpha: 0.99).
	evt hand releaseKeyboardFocus: self
]

{ #category : #'instance creation' }
CrossMorph >> open [
	<script: 'self new openInWorld'>
]

{ #category : #'stepping and presenter' }
CrossMorph >> step [

	(self color diff: Color black) < 0.1
		ifTrue: [ self color: (Color red alpha: 0.99 )]
		ifFalse: [ self color: self color darker ]
]

{ #category : #stepping }
CrossMorph >> stepTime [

	^ 100
]

{ #category : #geometry }
CrossMorph >> verticalBar [

	| crossWidth |
	crossWidth := (self width / 3.0) rounded.
	^ self bounds insetBy: crossWidth @ 0
]
