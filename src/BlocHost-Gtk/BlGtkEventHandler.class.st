"
I am a Gtk3 event handler.
I am responsible for convertion of Gtk3 events to bloc events and their enqueuing.

I know Gtk host space
"
Class {
	#name : #BlGtkEventHandler,
	#superclass : #Object,
	#instVars : [
		'hostSpace'
	],
	#category : 'BlocHost-Gtk'
}

{ #category : #converting }
BlGtkEventHandler >> convertButtonFromMouseEvent: aGdkEvent [

	aGdkEvent button = 1
		ifTrue: [ ^ BlMouseEvent primaryButton ].
	aGdkEvent button = 2
		ifTrue: [ ^ BlMouseEvent middleButton ].
	aGdkEvent button = 3
		ifTrue: [ ^ BlMouseEvent secondaryButton ].
	aGdkEvent button = 4
		ifTrue: [ ^ 4 ].
	aGdkEvent button = 5
		ifTrue: [ ^ 5 ]
]

{ #category : #converting }
BlGtkEventHandler >> convertKeyModifiersFromModState: modState [ 
	| shift ctrl alt gui |
	shift := (modState bitAnd: GdkModifierType GDK_SHIFT_MASK value) ~= 0.
	ctrl := (modState bitAnd: GdkModifierType GDK_CONTROL_MASK value) ~= 0.
	alt := (modState bitAnd: GdkModifierType GDK_MOD1_MASK value) ~= 0.
	gui := (modState bitAnd: GdkModifierType GDK_META_MASK value) ~= 0.
	
	^ BlKeyModifiers shift: shift ctrl: ctrl alt: alt cmd:gui
]

{ #category : #converting }
BlGtkEventHandler >> globalMousePositionForEvent: aGdkEvent [
	^ aGdkEvent x_root @ aGdkEvent y_root
]

{ #category : #accessing }
BlGtkEventHandler >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlGtkEventHandler >> hostSpace: anObject [
	hostSpace := anObject
]

{ #category : #accessing }
BlGtkEventHandler >> visitAnyEvent: aGdkEvent [
	 ^ nil
]

{ #category : #visiting }
BlGtkEventHandler >> visitButtonEvent: aGdkEvent [
	| evt |
	
	aGdkEvent type = GdkEventType GDK_BUTTON_PRESS
		ifTrue: [ evt := BlMouseDownEvent new ].
	aGdkEvent type = GdkEventType GDK_BUTTON_RELEASE
		ifTrue: [ evt := BlMouseUpEvent new ].
		
	evt
		position: aGdkEvent x @ aGdkEvent y;
		screenPosition: (self globalMousePositionForEvent: aGdkEvent);
		modifiers: (self convertKeyModifiersFromModState: aGdkEvent state);
		button: (self convertButtonFromMouseEvent: aGdkEvent);
		timestamp: Time millisecondClockValue.
		
	self hostSpace enqueueEvent: evt
]

{ #category : #accessing }
BlGtkEventHandler >> visitConfigureEvent: aGdkEvent [
	| evtResize evtMove|
	evtResize := BlSpaceResizeEvent new 
		extent: aGdkEvent width @ aGdkEvent height;
		timestamp: Time millisecondClockValue.
	
	"evtMove := BlSpaceMoveEvent new 
		position:  aGdkEvent x @ aGdkEvent y;
		timestamp: Time millisecondClockValue."
		
	self hostSpace enqueueEvent: evtResize.
	"self hostSpace enqueueEvent: evtMove"
]

{ #category : #accessing }
BlGtkEventHandler >> visitCrossingEvent: aGdkEvent [
	^ nil
]

{ #category : #accessing }
BlGtkEventHandler >> visitDeleteEvent: aGdkEvent [
	| evt |
	evt := BlSpaceCloseEvent new timestamp: Time millisecondClockValue.
	self hostSpace enqueueEvent: evt
]

{ #category : #accessing }
BlGtkEventHandler >> visitDestroyEvent: aGdkEvent [
	^ nil
]

{ #category : #accessing }
BlGtkEventHandler >> visitDndEvent: aGdkEvent [
	^ nil
]

{ #category : #accessing }
BlGtkEventHandler >> visitExposeEvent: aGdkEvent [
	 ^ nil
]

{ #category : #accessing }
BlGtkEventHandler >> visitFocusEvent: aGdkEvent [
	 ^ nil
]

{ #category : #accessing }
BlGtkEventHandler >> visitKeyEvent: aGdkEvent [
	 ^ nil
]

{ #category : #visiting }
BlGtkEventHandler >> visitMotionEvent: aGdkEvent [
	|evt|
	evt := BlMouseMoveEvent new
		position: aGdkEvent x @ aGdkEvent y;
		screenPosition: (self globalMousePositionForEvent: aGdkEvent);
		modifiers: (self convertKeyModifiersFromModState: aGdkEvent state);
		timestamp: Time millisecondClockValue.
		
	self hostSpace enqueueEvent: evt
]

{ #category : #accessing }
BlGtkEventHandler >> visitPropertyEvent: aGdkEvent [
	 ^ nil
]

{ #category : #accessing }
BlGtkEventHandler >> visitScrollEvent: aGdkEvent [
	 ^ nil
]

{ #category : #accessing }
BlGtkEventHandler >> visitWindowStateEvent: aGdkEvent [
	 ^ nil
]
