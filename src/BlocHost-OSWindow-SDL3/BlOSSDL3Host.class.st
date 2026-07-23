"
I am a host that opens spaces as OSWindow SDL3 windows.
"
Class {
	#name : #BlOSSDL3Host,
	#superclass : #BlPulseLoopHost,
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #'driver selection' }
BlOSSDL3Host class >> isSupported [

	^ OSWindowDriver current className = #OSSDL3Driver
]

{ #category : #printing }
BlOSSDL3Host >> label [

	^ 'SDL3'
]

{ #category : #'driver selection' }
BlOSSDL3Host class >> priority [
	
	^ 10
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
