"
I am a concrete implementation of a BlHost that allows users to open host bloc spaces within OSWindow windows
"
Class {
	#name : #BlOSWindowHost,
	#superclass : #BlHost,
	#instVars : [
		'wasRunning',
		'isRunning'
	],
	#category : 'BlocHost-OSWindow-Host'
}

{ #category : #'driver selection' }
BlOSWindowHost class >> isSupported [
	^ true
]

{ #category : #'driver selection' }
BlOSWindowHost class >> label [
	^ 'OS-Window'
]

{ #category : #'driver selection' }
BlOSWindowHost class >> priority [
	"Return host priority as positive number which influences host order
	and selection of a default host.
	Lower value - more likely host becomes a default"
	<return: #Number>
	
	^ 40
]

{ #category : #private }
BlOSWindowHost >> createAttributesFor: aSpace [
	| theAttributes |
	theAttributes := OSWindowAttributes new.
	theAttributes
		extent: aSpace extent;
		resizable: aSpace resizable;
		borderless: aSpace borderless;
		position: aSpace position;
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
BlOSWindowHost >> initialize [
	super initialize.
	
	isRunning := false
]

{ #category : #'host - api' }
BlOSWindowHost >> isRunning [
	"Return true if host is initialized and running"
	<return: #Boolean>

	^ isRunning
]

{ #category : #'host - api' }
BlOSWindowHost >> start [
	isRunning := true
]

{ #category : #'host - api' }
BlOSWindowHost >> stop [

	isRunning := false
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
