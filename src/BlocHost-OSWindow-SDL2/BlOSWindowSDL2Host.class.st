"
I am a host that opens spaces as OSWindow SDL2 windows.
"
Class {
	#name : #BlOSWindowSDL2Host,
	#superclass : #BlHost,
	#classInstVars : [
		'pulseLoop'
	],
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #'api - lifecycle' }
BlOSWindowSDL2Host class >> isRunning [

	^ self pulseLoop isRunning
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> isSupported [

	^ OSWindowDriver current className = #OSSDL2Driver
]

{ #category : #printing }
BlOSWindowSDL2Host class >> label [

	^ 'SDL2'
]

{ #category : #'driver selection' }
BlOSWindowSDL2Host class >> priority [
	
	^ 10
]

{ #category : #'api - lifecycle' }
BlOSWindowSDL2Host class >> pulsePeriod [

	^ self pulseLoop pulsePeriod
]

{ #category : #'api - lifecycle' }
BlOSWindowSDL2Host class >> pulsePeriod: aDuration [

	self pulseLoop pulsePeriod: aDuration
]

{ #category : #'api - lifecycle' }
BlOSWindowSDL2Host class >> start [

	self pulseLoop start
]

{ #category : #'api - lifecycle' }
BlOSWindowSDL2Host class >> stop [

	self pulseLoop stop
]

{ #category : #'api - ui process' }
BlOSWindowSDL2Host class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	self pulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #accessing }
BlOSWindowSDL2Host class >> pulseLoop [

	^ pulseLoop ifNil: [ pulseLoop := BlHostPulseLoop forHost: self ]
]

{ #category : #cleanup }
BlOSWindowSDL2Host class >> cleanUp [
	super cleanUp.
	pulseLoop := nil
]

{ #category : #initialization }
BlOSWindowSDL2Host >> keyboardKeyTable [

	^ BlOSWindowSDL2KeyboardKeyTable default
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
		universe: self universe;
		host: self;
		space: aSpace;
		initializeWithAttributes: (self newAttributesFor: aSpace);
		renderer: self newHostRenderer;
		yourself
]
