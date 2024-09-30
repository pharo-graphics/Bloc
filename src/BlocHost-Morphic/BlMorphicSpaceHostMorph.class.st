"
I act as a space host for a Bloc space
"
Class {
	#name : #BlMorphicSpaceHostMorph,
	#superclass : #Morph,
	#instVars : [
		'form',
		'eventHandler',
		'preventResize',
		'hostSpace'
	],
	#category : #'BlocHost-Morphic-Common'
}

{ #category : #drawing }
BlMorphicSpaceHostMorph >> drawOn: aCanvas [

	| spaceForm |
	super drawOn: aCanvas.

	spaceForm := form.
	spaceForm isNull ifTrue: [ ^ self ].
	hostSpace ifNil: [ ^ self ].

	aCanvas clipBy: self fullBounds during: [ :aClippedCanvas |
		SystemVersion current major >= 12
			ifTrue: [
				| formSet |
				formSet := (Smalltalk at: #FormSet)
					extent: self extent
					depth: spaceForm depth
					forms: { spaceForm }.
				aClippedCanvas drawFormSet: formSet at: self position ]
			ifFalse: [
				aClippedCanvas drawImage: spaceForm at: self position ] ]
]

{ #category : #geometry }
BlMorphicSpaceHostMorph >> extent: aPoint [
	
	self extent = aPoint ifTrue: [ ^ self ].
	
	super extent: aPoint.
	
	"morph may resize before host space is created"
	self hostSpace ifNil: [ ^ self ].

	self resizeDuring: [
		BlMorphicWindowResizeEvent new
			width: self width;
			height: self height;
			sentTo: eventHandler ]
]

{ #category : #accessing }
BlMorphicSpaceHostMorph >> form: aForm [

	form := aForm.
	self changed
]

{ #category : #'event handling' }
BlMorphicSpaceHostMorph >> handleKeystroke: anEvent [

	anEvent sentTo: eventHandler
]

{ #category : #'event handling' }
BlMorphicSpaceHostMorph >> handlesKeyboard: evt [

	^ true
]

{ #category : #'event handling' }
BlMorphicSpaceHostMorph >> handlesTextInputEvent: evt [
	"Do I want to receive text edition events?"

	^ true
]

{ #category : #accessing }
BlMorphicSpaceHostMorph >> hostSpace [

	^ hostSpace
]

{ #category : #accessing }
BlMorphicSpaceHostMorph >> hostSpace: aHostSpace [

	hostSpace := aHostSpace.
	self initializeAnnouncement
]

{ #category : #initialization }
BlMorphicSpaceHostMorph >> initialize [

	super initialize.

	eventHandler := BlMorphicEventHandler window: self.

	form := BlExternalForm extent: 1@1 depth: 32.
	form autoRelease.
	color := Color transparent.
	
	preventResize := false.

	"we prefer to fill parent"
	self hResizing: #spaceFill.
	self vResizing: #spaceFill
]

{ #category : #initialization }
BlMorphicSpaceHostMorph >> initializeAnnouncement [

	self
		onAnnouncement: MorphOpened
		do: [ :anEvent | anEvent sentTo: eventHandler ].

	self
		onAnnouncement: MorphDeleted
		do: [ :anEvent | anEvent sentTo: eventHandler ].

	self
		onAnnouncement: MorphGotFocus
		do: [ :anEvent | anEvent sentTo: eventHandler ].

	self
		onAnnouncement: MorphLostFocus
		do: [ :anEvent | anEvent sentTo: eventHandler ].

	self
		onAnnouncement: WindowResizing
		do: [ :anEvent |
			self resizeDuring: [
				BlMorphicWindowResizeEvent new
					width: self width;
					height: self height;
					sentTo: eventHandler ] ]
]

{ #category : #testing }
BlMorphicSpaceHostMorph >> isInSpaceArea: anEvent [
	"Return true if given morphic event is within space area, false otherwise"
	
	^ self bounds containsPoint: anEvent position
]

{ #category : #'event handling' }
BlMorphicSpaceHostMorph >> keyDown: anEvent [

	anEvent sentTo: eventHandler
]

{ #category : #'event handling' }
BlMorphicSpaceHostMorph >> keyUp: anEvent [

	anEvent sentTo: eventHandler
]

{ #category : #geometry }
BlMorphicSpaceHostMorph >> pointToSpace: aPoint [

	^ aPoint - self position
]

{ #category : #'events-processing' }
BlMorphicSpaceHostMorph >> processEvent: anEvent using: defaultDispatcher [
	
	((self isInSpaceArea: anEvent) and: [
		(anEvent isMouse and: [
			anEvent isMouseDown and: [
				anEvent isSpecialGesture ] ]) not ])
		ifFalse: [ ^ super processEvent: anEvent using: defaultDispatcher ].

	anEvent sentTo: eventHandler.
	
	"quick fix for issue #15 : 
	In morphic, if the drop event is marked as handled, the dragged window is removed"
	anEvent isDropEvent ifFalse: [ anEvent wasHandled: true ]
]

{ #category : #geometry }
BlMorphicSpaceHostMorph >> resizeDuring: aBlock [

	preventResize ifTrue: [ ^ self ].
	preventResize := true.
	aBlock ensure: [ preventResize := false ]
]

{ #category : #testing }
BlMorphicSpaceHostMorph >> takesKeyboardFocus [
	"Answer whether the receiver can normally take keyboard focus."

	^ true
]

{ #category : #'event handling' }
BlMorphicSpaceHostMorph >> textInput: aTextInputEvent [

	aTextInputEvent sentTo: eventHandler
]

{ #category : #testing }
BlMorphicSpaceHostMorph >> wantsKeyboardFocus [
	"Answer whether the receiver would like keyboard focus
	in the general case (mouse action normally)."

	^ true
]
