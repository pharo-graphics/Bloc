"
I am a concrete implementation of a BlHostSpace.
My responsibility is to control OSWindow window using unified host space api.
"
Class {
	#name : #BlOSSDL3HostSpace,
	#superclass : #BlHostSpace,
	#traits : 'TBlSpaceProperties',
	#classTraits : 'TBlSpaceProperties classTrait',
	#instVars : [
		'eventFetcher',
		'keyboardKeyTable',
		'osWindow'
	],
	#pools : [
		'SDL3AllEnumerations'
	],
	#category : #'BlocHost-OSWindow-SDL3'
}

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> borderless: aBoolean [

	osWindow borderless: aBoolean
]

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> center [

	osWindow center
]

{ #category : #'host space - displaying' }
BlOSSDL3HostSpace >> close [

	self isValid ifTrue: [ osWindow destroy ].

	osWindow := nil
]

{ #category : #'host space - cursor' }
BlOSSDL3HostSpace >> cursor: aCursor [

	osWindow setMouseCursor: aCursor
]

{ #category : #'host space - geometry' }
BlOSSDL3HostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch (a float)"
	
	^ 96.0
]

{ #category : #'host space - events' }
BlOSSDL3HostSpace >> enqueueEvent: aBlEvent [
	"I put events in a queue to be processed later"

	self eventFetcher enqueueEvent: aBlEvent
]

{ #category : #'host space - accessing' }
BlOSSDL3HostSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"

	^ eventFetcher
]

{ #category : #'host space - events' }
BlOSSDL3HostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
	
	self eventFetcher fetchedEventsDo: aBlock
]

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	osWindow fullscreen: aBoolean
]

{ #category : #'host space - displaying' }
BlOSSDL3HostSpace >> hide [

	osWindow hide
]

{ #category : #initialization }
BlOSSDL3HostSpace >> initialize [

	super initialize.

	eventFetcher := BlHostEventFetcher hostSpace: self
]

{ #category : #initialization }
BlOSSDL3HostSpace >> initializeWithAttributes: initialAttributes [

	osWindow := OSWindow createWithAttributes: initialAttributes.
	osWindow eventHandler:
		(BlOSWindowEventHandler
			window: self
			time: space time
			keyboardKeyTable: keyboardKeyTable).
	osWindow startTextInput.
	osWindow newBlocRenderer
]

{ #category : #'dirty areas' }
BlOSSDL3HostSpace >> invalidate [
	
	osWindow := nil
]

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> isBorderless [

	^ osWindow borderless
]

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> isFullscreen [
	"Return true if an underlying window is in fullscreen mode, false otherwise."

	^ osWindow fullscreen
]

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> isResizable [	
	"Return true if underlying window is resizable, false otherwise"

	^ osWindow resizable
]

{ #category : #'window - text input' }
BlOSSDL3HostSpace >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"

	^ osWindow isTextInputActive
]

{ #category : #'host space - testing' }
BlOSSDL3HostSpace >> isValid [

	^ osWindow isNotNil and: [ osWindow isValid ]
]

{ #category : #'host space - testing' }
BlOSSDL3HostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"

	^ osWindow isVisible
]

{ #category : #private }
BlOSSDL3HostSpace >> keyboardKeyTable: aKeyboardKeyTable [

	keyboardKeyTable := aKeyboardKeyTable
]

{ #category : #'host space - geometry' }
BlOSSDL3HostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ osWindow extent asLogicalSize
]

{ #category : #'host space - displaying' }
BlOSSDL3HostSpace >> maximize [

	osWindow maximize
]

{ #category : #'host space - displaying' }
BlOSSDL3HostSpace >> maximized [

	^ osWindow maximized
]

{ #category : #'host space - displaying' }
BlOSSDL3HostSpace >> minimize [

	osWindow minimize
]

{ #category : #'host space - displaying' }
BlOSSDL3HostSpace >> minimized [

	^ osWindow minimized
]

{ #category : #'host space - geometry' }
BlOSSDL3HostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	^ osWindow canvasExtent asPhysicalSize
]

{ #category : #'host space - geometry' }
BlOSSDL3HostSpace >> position [
	"Return window's position in screen coordinates"

	^ osWindow position
]

{ #category : #'host space - geometry' }
BlOSSDL3HostSpace >> position: aPoint [

	osWindow position: aPoint
]

{ #category : #'host space - rendering' }
BlOSSDL3HostSpace >> render: aSpace [

	self isValid ifFalse: [ ^ self ].
	OSWindowRenderThread uniqueInstance critical: [ self renderer render: self ]
]

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> resizable: aBoolean [

	osWindow resizable: aBoolean
]

{ #category : #'host space - displaying' }
BlOSSDL3HostSpace >> show [

	osWindow show
]

{ #category : #'window - text input' }
BlOSSDL3HostSpace >> startTextInput [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	osWindow startTextInput
]

{ #category : #'window - text input' }
BlOSSDL3HostSpace >> startTextInputAtRectangle: aRectangle [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	osWindow startTextInputAtRectangle: aRectangle
]

{ #category : #'window - text input' }
BlOSSDL3HostSpace >> stopTextInput [

	self flag: 'Do nothing for now since the current implementation is not thread safe.
	Bloc and Morphic can run in parallel on the same backend window in case a Morphic host is used for Bloc.
	The consequence is that text input is not activate when switching from a Morph to a BlElement because a stopTextInput can be sent from a Morph ** after ** a startTextInput has been correctly sent from a BlElement.'.

	"sdl3Window stopTextInput"
]

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> title [

	^ osWindow title
]

{ #category : #'window - properties' }
BlOSSDL3HostSpace >> title: aString [

	osWindow title: aString
]

{ #category : #'host space - geometry' }
BlOSSDL3HostSpace >> windowExtent: newExtent [

	self logicalSize asPoint ~= newExtent
		ifTrue: [ osWindow extent: newExtent ]
]
