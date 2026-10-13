"
I am an abstract host for OSWindow SDL-based windows. My concrete subclasses represent specific SDL versions (such as SDL2 or SDL3).
"
Class {
	#name : #BlSDLHost,
	#superclass : #BlPulseLoopHost,
	#category : #'BlocHost-OSWindow'
}

{ #category : #'driver selection' }
BlSDLHost class >> default [

	^ self supportedHostClass default
]

{ #category : #'driver selection' }
BlSDLHost class >> driverClassName [

	^ nil
]

{ #category : #'driver selection' }
BlSDLHost class >> isSupported [

	^ self driverClassName
		ifNotNil: [ :aName | OSWindowDriver current className = aName ]
		ifNil: [ false ]
]

{ #category : #'driver selection' }
BlSDLHost class >> order [

	^ 10
]

{ #category : #'driver selection' }
BlSDLHost class >> supportedHostClass [

	^ self allSubclasses
		detect: [ :each | each isSupported ]
		ifNone: [ self error: 'No supported SDL host for current driver' ]
]

{ #category : #initialization }
BlSDLHost >> hostSpaceClass [

	^ self subclassResponsibility
]

{ #category : #initialization }
BlSDLHost >> keyboardKeyTable [

	^ self subclassResponsibility
]

{ #category : #accessing }
BlSDLHost >> label [

	^ 'SDL'
]

{ #category : #private }
BlSDLHost >> newAttributesFor: aSpace [

	| theAttributes |
	theAttributes := OSWindowAttributes new
		title: aSpace title;
		extent: aSpace extent;
		resizable: aSpace isResizable;
		borderless: aSpace isBorderless;
		fullscreen: aSpace isFullscreen;
		visible: false; "Start hidden so the OS does not dispatch expose/focus
		events before the event handler and renderer are attached."
		yourself.

	aSpace knowsPosition
		ifTrue: [ theAttributes position: aSpace position ]
		ifFalse: [ theAttributes windowCentered: true ].

	^ theAttributes
]

{ #category : #'host - api' }
BlSDLHost >> newHostSpaceFor: aSpace [
	"Create and assign a new host space for given Bloc space"
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space."

	^ self hostSpaceClass new
		keyboardKeyTable: self keyboardKeyTable;
		host: self;
		space: aSpace;
		initializeWithAttributes: (self newAttributesFor: aSpace);
		renderer: self newHostRenderer;
		yourself
]
