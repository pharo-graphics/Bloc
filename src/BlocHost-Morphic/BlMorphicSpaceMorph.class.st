"
I am used to embed Bloc elements in Morphic world
"
Class {
	#name : #BlMorphicSpaceMorph,
	#superclass : #Morph,
	#instVars : [
		'form',
		'defered',
		'eventHandler',
		'preventResize',
		'hostSpace'
	],
	#category : #'BlocHost-Morphic-Morphs'
}

{ #category : #drawing }
BlMorphicSpaceMorph >> drawOn: aCanvas [
	| spaceForm |
	super drawOn: aCanvas.

	spaceForm := form.
	spaceForm isNull
		ifTrue: [ ^ self ].
	hostSpace ifNotNil: [ 
		hostSpace lock critical: [
			aCanvas clipBy: self fullBounds during: [ :aClippedCanvas |
				aClippedCanvas drawImage: spaceForm at: self position ] ] ]
]

{ #category : #geometry }
BlMorphicSpaceMorph >> extent: aPoint [
	super extent: aPoint.
	
	"morph may resize before host space is created"
	self hostSpace
		ifNil: [ ^ self ].
	
	self resizeDuring: [
		BlMorphicWindowResizeEvent new
			width: self width;
			height: self height;
			sentTo: eventHandler ]
]

{ #category : #accessing }
BlMorphicSpaceMorph >> form: aForm [
	
	form := aForm.
	
	defered
		ifTrue: [ ^ self ].
	 
	defered := true.
	self defer: [
		defered := false.
		self changed ]
]

{ #category : #'event handling' }
BlMorphicSpaceMorph >> handleKeystroke: anEvent [
	anEvent sentTo: eventHandler
]

{ #category : #'event handling' }
BlMorphicSpaceMorph >> handlesKeyboard: evt [
	^ true
]

{ #category : #accessing }
BlMorphicSpaceMorph >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlMorphicSpaceMorph >> hostSpace: aHostSpace [
	
	hostSpace := aHostSpace.	
	self initializeAnnouncement
]

{ #category : #initialization }
BlMorphicSpaceMorph >> initialize [
	super initialize.
	
	eventHandler := BlMorphicEventHandler window: self.
	
	form := BlExternalForm extent: 1@1 depth: 32.
	form autoRelease.
	color := Color transparent.
	defered := false.
	
	preventResize := false.

	"we prefer to fill parent"
	self hResizing: #spaceFill.
	self vResizing: #spaceFill
]

{ #category : #initialization }
BlMorphicSpaceMorph >> initializeAnnouncement [
	self
		onAnnouncement: MorphOpened
		do: [ :anEvent | BlMorphicWindowOpenedEvent new sentTo: eventHandler ].

	self
		onAnnouncement: MorphDeleted
		do: [ :anEvent | BlMorphicWindowClosedEvent new sentTo: eventHandler ].

	self
		onAnnouncement: MorphGotFocus
		do: [ :evt | ].

	self
		onAnnouncement: MorphLostFocus
		do: [ :evt | ].

	self
		onAnnouncement: WindowResizing
		do: [ :evt |
			self resizeDuring: [
				BlMorphicWindowResizeEvent new
					width: self width;
					height: self height;
					sentTo: eventHandler ] ]
]

{ #category : #testing }
BlMorphicSpaceMorph >> isInSpaceArea: anEvent [
	"Return true if given morphic event is within space area, false otherwise"
	<return: #Boolean>
	
	^ self bounds containsPoint: anEvent position
]

{ #category : #'event handling' }
BlMorphicSpaceMorph >> keyDown: anEvent [
	anEvent sentTo: eventHandler
]

{ #category : #'event handling' }
BlMorphicSpaceMorph >> keyUp: anEvent [
	anEvent sentTo: eventHandler
]

{ #category : #geometry }
BlMorphicSpaceMorph >> pointToSpace: aPoint [

	^ aPoint - self spacePosition
]

{ #category : #'events-processing' }
BlMorphicSpaceMorph >> processEvent: anEvent using: defaultDispatcher [
	
	(self isInSpaceArea: anEvent)
		ifFalse: [ ^ super processEvent: anEvent using: defaultDispatcher ].

	anEvent sentTo: eventHandler.
	
	"quick fix for issue #15 : 
	In morphic, if the drop event is marked as handled, the dragged window is removed"
	anEvent isDropEvent
		ifFalse: [ anEvent wasHandled: true ]
]

{ #category : #geometry }
BlMorphicSpaceMorph >> resizeDuring: aBlock [
	
	preventResize
		ifTrue: [ ^ self ].
	
	preventResize := true.
	aBlock ensure: [ preventResize := false ]
]

{ #category : #geometry }
BlMorphicSpaceMorph >> spacePosition [
	"Return position of space area"
	<return: #Point>

	^ self position
]

{ #category : #testing }
BlMorphicSpaceMorph >> takesKeyboardFocus [
	"Answer whether the receiver can normally take keyboard focus."

	^ true
]

{ #category : #testing }
BlMorphicSpaceMorph >> wantsKeyboardFocus [
	"Answer whether the receiver would like keyboard focus
	in the general case (mouse action normally)."

	^ true
]
