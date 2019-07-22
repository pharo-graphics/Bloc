"
I am a special case of StandardWindow that is used as host window for bloc space.

I provide helper methods to be used by event handler and moprhic host space
"
Class {
	#name : #BlMorphicWindow,
	#superclass : #StandardWindow,
	#instVars : [
		'form',
		'spaceForm',
		'eventHandler',
		'hostSpace',
		'mutex',
		'preventResize'
	],
	#category : #'BlocHost-Morphic-Host - Window'
}

{ #category : #accessing }
BlMorphicWindow >> borderless: aBoolean [
	"Make window borderless if true is given"
	
	aBoolean ifTrue: [ 
		self
			makeBorderless;
			beWithoutGrips;
			removeLabelArea
	]
]

{ #category : #accessing }
BlMorphicWindow >> form: aCanvasForm [

	spaceForm form: aCanvasForm
]

{ #category : #'event handling' }
BlMorphicWindow >> handleKeystroke: anEvent [
	anEvent sentTo: eventHandler
]

{ #category : #'event handling' }
BlMorphicWindow >> handlesKeyboard: evt [
	^ true
]

{ #category : #accessing }
BlMorphicWindow >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlMorphicWindow >> hostSpace: aHostSpace [
	
	hostSpace := aHostSpace.
	spaceForm hostSpace: aHostSpace.
	
	self initializeAnnouncement
]

{ #category : #initialization }
BlMorphicWindow >> initialize [
	super initialize.

	spaceForm := BlMorphicExternalFormMorph new.
	self addMorph: spaceForm fullFrame: (0@0 extent: 1@1).

	eventHandler := BlMorphicEventHandler window: self.
	mutex := Mutex new.
	preventResize := false
]

{ #category : #initialization }
BlMorphicWindow >> initializeAnnouncement [
	self
		onAnnouncement: WindowOpened
		do: [ :anEvent |
			BlMorphicWindowOpenedEvent new sentTo: eventHandler.
			spaceForm startStepping ].

	self
		onAnnouncement: WindowClosed
		do: [ :anEvent |
			spaceForm stopStepping.
			BlMorphicWindowClosedEvent new sentTo: eventHandler ].

	self
		onAnnouncement: MorphGotFocus
		do: [ :evt | ].

	self
		onAnnouncement: MorphLostFocus
		do: [ :evt | ].

	self
		onAnnouncement: WindowResizing
		do: [ :evt | 
			self resizeDuring: [ BlMorphicWindowResizeEvent new
				width: self spaceExtent x;
				height: self spaceExtent y;
				sentTo: eventHandler ] ]
]

{ #category : #testing }
BlMorphicWindow >> isInSpaceArea: anEvent [
	"Return true if given morphic event is within space area, false otherwise"
	<return: #Boolean>
	
	^ spaceForm fullBounds containsPoint: anEvent position
]

{ #category : #'event handling' }
BlMorphicWindow >> keyDown: anEvent [
	anEvent sentTo: eventHandler
]

{ #category : #'event handling' }
BlMorphicWindow >> keyUp: anEvent [
	anEvent sentTo: eventHandler
]

{ #category : #geometry }
BlMorphicWindow >> pointToSpace: aPoint [

	^ aPoint - self spacePosition
]

{ #category : #'events-processing' }
BlMorphicWindow >> processEvent: anEvent using: defaultDispatcher [
	
	(self isInSpaceArea: anEvent)
		ifFalse: [ ^ super processEvent: anEvent using: defaultDispatcher ].

	anEvent sentTo: eventHandler.
	
	"quick fix for issue #15 : 
	In morphic, if the drop event is mark as handled, the dragged window is removed"
	anEvent isDropEvent
		ifFalse: [ anEvent wasHandled: true ]
]

{ #category : #geometry }
BlMorphicWindow >> resizeDuring: aBlock [
	
	preventResize
		ifTrue: [ ^ self ].
	
	preventResize := true.
	aBlock ensure: [ preventResize := false ]
]

{ #category : #geometry }
BlMorphicWindow >> spaceExtent [
	| aDelta |
	
	"we compute decorations extent first"
	aDelta := self fullBounds extent - spaceForm extent.
	^ self extent - aDelta
]

{ #category : #geometry }
BlMorphicWindow >> spaceExtent: anExtent [

	self resizeDuring: [
		self spaceExtent = anExtent
			ifFalse: [
				| aDelta |
				"we compute decorations extent first"
				aDelta := self fullBounds extent - spaceForm extent.
				super extent: anExtent + aDelta ] ]
]

{ #category : #geometry }
BlMorphicWindow >> spacePosition [
	"Return position of space area"
	<return: #Point>

	^ spaceForm position
]

{ #category : #stepping }
BlMorphicWindow >> step [
]

{ #category : #stepping }
BlMorphicWindow >> stepTime [
	^ 0  "every cycle"
]

{ #category : #testing }
BlMorphicWindow >> takesKeyboardFocus [
	"Answer whether the receiver can normally take keyboard focus."

	^ true
]

{ #category : #testing }
BlMorphicWindow >> wantsKeyboardFocus [
	"Answer whether the receiver would like keyboard focus
	in the general case (mouse action normally)."

	^ true
]
