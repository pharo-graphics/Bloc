"
I am a concrete implementation of a BlHostSpace.
My responsibility is to control OSWindow window using unified host space api.
"
Class {
	#name : #BlOSWindowSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace + TBlSpaceProperties',
	#classTraits : 'TBlHostSpace classTrait + TBlSpaceProperties classTrait',
	#instVars : [
		'window',
		'eventFetcher',
		'keyboardKeyTable'
	],
	#category : #'BlocHost-OSWindow-Host'
}

{ #category : #'window - properties' }
BlOSWindowSpace >> borderless [
	^ window borderless
]

{ #category : #'window - properties' }
BlOSWindowSpace >> borderless: aBoolean [
	window borderless: aBoolean
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> close [
	
	self isValid
		ifTrue: [ window destroy ].
		
	(BlOSWindowDestroyedSignal new window: window) emit.

	window := nil
]

{ #category : #'host space - cursor' }
BlOSWindowSpace >> cursor: aCursor [
	"self windowDo: [ :aWindow | aWindow setMouseCursor: aCursor ]"
]

{ #category : #'host space - geometry' }
BlOSWindowSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'host space - events' }
BlOSWindowSpace >> enqueueEvent: aBlEvent [
	"I put events in a queue to be processed later"

	self eventFetcher enqueueEvent: aBlEvent
]

{ #category : #'host space - accessing' }
BlOSWindowSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"
	<return: #BlHostEventFetcher>

	^ eventFetcher
]

{ #category : #'host space - events' }
BlOSWindowSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
	
	self eventFetcher fetchedEventsDo: aBlock
]

{ #category : #'window - properties' }
BlOSWindowSpace >> fullscreen [
	"Return true if an underlying window is in fullscreen mode,
	false otherwise"
	<return: #Boolean>

	^ window fullscreen
]

{ #category : #'window - properties' }
BlOSWindowSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	window fullscreen: aBoolean
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> hide [
	window hide
]

{ #category : #initialization }
BlOSWindowSpace >> initialize [
	super initialize.
	
	eventFetcher := BlHostEventFetcher hostSpace: self.
]

{ #category : #initialization }
BlOSWindowSpace >> initializeWithAttributes: initialAttributes [
	
	self
		assert: [ window isNil or: [ window isValid not ] ]
		description: [ 'Window must be nil or invalid' ].

	window := OSWindow createWithAttributes: initialAttributes.
	window eventHandler: ((BlOSWindowEventHandler window: self) keyboardKeyTable: keyboardKeyTable).
	window startTextInput.
	window newBlocRenderer.
	
	(BlOSWindowCreatedSignal new window: window) emit
]

{ #category : #testing }
BlOSWindowSpace >> isValid [
	^ window isNotNil and: [ window isValid ]
]

{ #category : #'host space - testing' }
BlOSWindowSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"
	<return: #Boolean>

	^ window isVisible
]

{ #category : #private }
BlOSWindowSpace >> keyboardKeyTable: aKeyboardKeyTable [
	keyboardKeyTable := aKeyboardKeyTable
]

{ #category : #'host space - geometry' }
BlOSWindowSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."
	<return: #FensterLogicalSize>

	^ window extent asLogicalSize
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> maximize [
	window maximize
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> maximized [
	^ window maximized
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> minimize [
	window minimize
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> minimized [
	^ window minimized
]

{ #category : #'host space - testing' }
BlOSWindowSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	<return: #Boolean>
	
	^ self isValid not
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> open [
	window show
]

{ #category : #'host space - geometry' }
BlOSWindowSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."
	<return: #FensterPhysicalSize>

	| anExtent |
	anExtent := window canvasExtent.
	^ FensterPhysicalSize width: anExtent x height: anExtent y
]

{ #category : #'host space - geometry' }
BlOSWindowSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>

	^ window position
]

{ #category : #'host space - geometry' }
BlOSWindowSpace >> position: aPoint [
	window position: aPoint
]

{ #category : #'host space - rendering' }
BlOSWindowSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	OSWindowRenderThread uniqueInstance critical: [ self renderer render: self ]
]

{ #category : #'window - properties' }
BlOSWindowSpace >> resizable [	
	"Return true if underlying window is resizable, false otherwise"
	<return: #Boolean>

	^ window resizable
]

{ #category : #'window - properties' }
BlOSWindowSpace >> resizable: aBoolean [
	window resizable: aBoolean
]

{ #category : #'host space - displaying' }
BlOSWindowSpace >> show [
	window show
]

{ #category : #'window - properties' }
BlOSWindowSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ window title
]

{ #category : #'window - properties' }
BlOSWindowSpace >> title: aString [
	"Change window's title"

	window title: aString
]

{ #category : #'host space - geometry' }
BlOSWindowSpace >> windowExtent: newExtent [
	"Change window size to a newExtent"

	self logicalSize width @ self logicalSize height ~= newExtent
		ifTrue: [ window extent: newExtent ]
]
