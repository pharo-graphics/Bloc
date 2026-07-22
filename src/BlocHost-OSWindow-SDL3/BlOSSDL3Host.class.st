"
I am a host that opens spaces as OSWindow SDL3 windows.
"
Class {
	#name : #BlOSSDL3Host,
	#superclass : #BlHost,
	#classInstVars : [
		'pulseLoop'
	],
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #'api - lifecycle' }
BlOSSDL3Host class >> isRunning [

	^ self pulseLoop isRunning
]

{ #category : #'driver selection' }
BlOSSDL3Host class >> isSupported [

	^ OSWindowDriver current className = #OSSDL3Driver
]

{ #category : #printing }
BlOSSDL3Host class >> label [

	^ 'SDL3'
]

{ #category : #'driver selection' }
BlOSSDL3Host class >> priority [
	
	^ 10
]

{ #category : #'api - lifecycle' }
BlOSSDL3Host class >> pulsePeriod [

	^ self pulseLoop pulsePeriod
]

{ #category : #'api - lifecycle' }
BlOSSDL3Host class >> pulsePeriod: aDuration [

	self pulseLoop pulsePeriod: aDuration
]

{ #category : #'api - lifecycle' }
BlOSSDL3Host class >> start [

	self pulseLoop start
]

{ #category : #'api - lifecycle' }
BlOSSDL3Host class >> stop [

	self pulseLoop stop
]

{ #category : #'api - ui process' }
BlOSSDL3Host class >> uiProcessDo: aBlock [
	"Evaluate aBlock with the running UI Process of this host if any"
	
	self pulseLoop loopProcess ifNotNil: aBlock
]

{ #category : #accessing }
BlOSSDL3Host class >> pulseLoop [

	^ pulseLoop ifNil: [ pulseLoop := BlHostPulseLoop forHost: self ]
]

{ #category : #cleanup }
BlOSSDL3Host class >> cleanUp [
	super cleanUp.
	pulseLoop := nil
]

{ #category : #initialization }
BlOSSDL3Host >> keyboardKeyTable [

	^ BlOSSDL3KeyTable default
]

{ #category : #private }
BlOSSDL3Host >> newAttributesFor: aSpace [

	| theAttributes |
	theAttributes := OSWindowAttributes new
		title: aSpace title;
		extent: aSpace extent;
		resizable: aSpace isResizable;
		borderless: aSpace isBorderless;
		visible: false; "There is a race before opening a window and setting the event handler."
		yourself.

	aSpace knowsPosition
		ifTrue: [ theAttributes position: aSpace position ]
		ifFalse: [ theAttributes windowCentered: true ].

	^ theAttributes
]

{ #category : #'host - api' }
BlOSSDL3Host >> newHostSpaceFor: aSpace [
	"Create and assign a new host space for given Bloc space"
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space."

	^ BlOSSDL3Renderer defaultClass hostSpaceClass new
		keyboardKeyTable: self keyboardKeyTable;
		universe: self universe;
		host: self;
		space: aSpace;
		initializeWithAttributes: (self newAttributesFor: aSpace);
		renderer: self newHostRenderer;
		yourself
]
