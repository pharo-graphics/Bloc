"
I am a host that opens spaces as OSWindow SDL2 windows.
"
Class {
	#name : #BlOSWindowSDL2Host,
	#superclass : #BlPulseLoopHost,
	#traits : 'TBlSingletonHost',
	#classTraits : 'TBlSingletonHost classTrait',
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> isSupported [

	^ OSWindowDriver current className = #OSSDL2Driver
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> priority [
	
	^ 10
]

{ #category : #initialization }
BlOSWindowSDL2Host >> keyboardKeyTable [

	^ BlOSWindowSDL2KeyboardKeyTable default
]

{ #category : #accessing }
BlOSWindowSDL2Host >> label [

	^ 'SDL2'
]

{ #category : #private }
BlOSWindowSDL2Host >> newAttributesFor: aSpace [

	| theAttributes |
	theAttributes := OSWindowAttributes new
		title: aSpace title;
		extent: aSpace extent;
		resizable: aSpace isResizable;
		borderless: aSpace isBorderless;
		fullscreen: aSpace isFullscreen;
		visible: false; "There is a race before opening a window and setting the event handler."
		yourself.

	aSpace knowsPosition
		ifTrue: [ theAttributes position: aSpace position ]
		ifFalse: [ theAttributes windowCentered: true ].

	theAttributes glAttributes:
		(OSWindowGLAttributes new
			redSize: 8;
			greenSize: 8;
			blueSize: 8;
			stencilSize: 8;
			yourself).

	^ theAttributes
]

{ #category : #'host - api' }
BlOSWindowSDL2Host >> newHostSpaceFor: aSpace [
	"Create and assign a new host space for given Bloc space"
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space."

	^ BlOSWindowSDL2HostSpace new
		keyboardKeyTable: self keyboardKeyTable;
		host: self;
		space: aSpace;
		initializeWithAttributes: (self newAttributesFor: aSpace);
		renderer: self newHostRenderer;
		yourself
]
