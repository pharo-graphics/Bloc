"
I am a concrete implementation of a BlHost that allows users to open host bloc spaces within OSWindow windows.

OSWindow is an abstraction of different windowing backends, for example SDL2 or Glutin. See my subclasses for available backends.

OSWindow host relies on native windows that already have their own event loop, therefore I do event fetching and rendering in the same UI thread
"
Class {
	#name : #BlOSWindowHost,
	#superclass : #BlHost,
	#category : #'BlocHost-OSWindow-Host'
}

{ #category : #private }
BlOSWindowHost >> createAttributesFor: aSpace [

	| theAttributes |
	theAttributes := OSWindowAttributes new
		title: aSpace title;
		extent: aSpace extent;
		resizable: aSpace isResizable;
		borderless: aSpace isBorderless;
		visible: false; "There is a race before opening a window and setting the event handler."
		yourself.

	aSpace knowsPosition ifTrue: [ 
		theAttributes position: aSpace position ].

	^ theAttributes
]

{ #category : #private }
BlOSWindowHost >> createHostSpace [

	^ BlOSWindowHostSpace new
]

{ #category : #private }
BlOSWindowHost >> createWindowSpaceFor: aSpace [
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space."

	| aHostSpace theGLAttributes theWindowAttributes |
	theGLAttributes := OSWindowGLAttributes new
		redSize: 8;
		greenSize: 8;
		blueSize: 8;
		stencilSize: 8;
		yourself.
	
	theWindowAttributes := self createAttributesFor: aSpace.
	theWindowAttributes glAttributes: theGLAttributes.
	
	aHostSpace := self createHostSpace.
	aHostSpace
		keyboardKeyTable: self keyboardKeyTable;
		universe: self universe;
		host: self;
		space: aSpace;
		initializeWithAttributes: theWindowAttributes.
	
	^ aHostSpace
]

{ #category : #'host - api' }
BlOSWindowHost >> destroyHostSpaceFor: aSpace [
	"Closes OSWindow window and unrefer it from bloc space"
	
	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #initialization }
BlOSWindowHost >> keyboardKeyTable [

	^ self subclassResponsibility
]
