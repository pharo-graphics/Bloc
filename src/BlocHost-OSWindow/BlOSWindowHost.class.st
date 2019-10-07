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

{ #category : #'instance creation' }
BlOSWindowHost class >> default [
	"Pick a specific OSWindow backend from available ones"
	<return: #BlOSWindowHost>

	^ BlOSWindowHost suitableHostClass new
]

{ #category : #'instance creation' }
BlOSWindowHost class >> new [
	self = BlOSWindowHost
		ifTrue: [ self error: 'Please use #default instead to pick up a suitable backend' ].

	^ self basicNew initialize
]

{ #category : #private }
BlOSWindowHost >> createAttributesFor: aSpace [
	| theAttributes |
	theAttributes := OSWindowAttributes new.
	theAttributes
		title: aSpace title;
		extent: aSpace extent;
		resizable: aSpace resizable;
		borderless: aSpace borderless;
		position: aSpace position;
		preferableDriver: self preferableDriver;
		visible: false. "There is a race before opening a window and setting the event handler."
	^ theAttributes
]

{ #category : #'host - api' }
BlOSWindowHost >> createHostSpaceFor: aSpace [
	"Create and assign a new oswindow host space for given bloc space"
	| aHostSpace|

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Space must not have a host!' ].
	
	aHostSpace := self createWindowSpaceFor: aSpace.
	aHostSpace keyboardKeyTable: self keyboardKeyTable.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.

	aSpace hostSpace: aHostSpace
]

{ #category : #private }
BlOSWindowHost >> createWindowSpaceFor: aSpace [
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space"
	
	^ BlOSWindowSpace new
]

{ #category : #'host - api' }
BlOSWindowHost >> destroyHostSpaceFor: aSpace [
	"Closes OSWindow window and unrefer it from bloc space"
	
	aSpace hostSpace close.
	aSpace detachHostSpace
]

{ #category : #initialization }
BlOSWindowHost >> keyboardKeyTable [
	^ self subclassResponsibility
]

{ #category : #'host - events' }
BlOSWindowHost >> pollEvents [
	self subclassResponsibility
]

{ #category : #initialization }
BlOSWindowHost >> preferableDriver [
	<return: #OSWindowDriver>

	^ self subclassResponsibility
]

{ #category : #'host - testing' }
BlOSWindowHost >> supportsBufferSurface [
	"Return true if this host can work with buffer surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #'host - testing' }
BlOSWindowHost >> supportsFormSurface [
	"Return true if this host can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #'host - testing' }
BlOSWindowHost >> supportsOpenGLSurface [
	"Return true if this host can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ false
]
