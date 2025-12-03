"
I am a concrete implementation of a BlHostSpace.
My responsibility is to control OSWindow window using unified host space api.
"
Class {
	#name : #BlOSWindowSDL2HostSpace,
	#superclass : #BlHostSpace,
	#traits : 'TBlSpaceProperties',
	#classTraits : 'TBlSpaceProperties classTrait',
	#instVars : [
		'window',
		'eventFetcher',
		'keyboardKeyTable',
		'sdlRenderer',
		'texture',
		'pitchAddress',
		'pixelsAddress',
		'sdlRect',
		'logicalWindowRectangle'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> borderless: aBoolean [
	window borderless: aBoolean
]

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> center [
	window center
]

{ #category : #'host space - displaying' }
BlOSWindowSDL2HostSpace >> close [

	self isValid ifTrue: [ window destroy ].

	window := nil
]

{ #category : #'host space - cursor' }
BlOSWindowSDL2HostSpace >> cursor: aCursor [

	window setMouseCursor: aCursor
]

{ #category : #'host space - geometry' }
BlOSWindowSDL2HostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch (a float)"
	
	^ 96.0
]

{ #category : #'host space - events' }
BlOSWindowSDL2HostSpace >> enqueueEvent: aBlEvent [
	"I put events in a queue to be processed later"

	self eventFetcher enqueueEvent: aBlEvent
]

{ #category : #'host space - accessing' }
BlOSWindowSDL2HostSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"

	^ eventFetcher
]

{ #category : #'host space - events' }
BlOSWindowSDL2HostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
	
	self eventFetcher fetchedEventsDo: aBlock
]

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	window fullscreen: aBoolean
]

{ #category : #'host space - displaying' }
BlOSWindowSDL2HostSpace >> hide [
	window hide
]

{ #category : #initialization }
BlOSWindowSDL2HostSpace >> initialize [

	super initialize.

	eventFetcher := BlHostEventFetcher hostSpace: self
]

{ #category : #initialization }
BlOSWindowSDL2HostSpace >> initializeRenderer [

	| textureExtent |
	super initializeRenderer.

 	pitchAddress := ExternalAddress newPointer.
	pixelsAddress := ExternalAddress newPointer.
	sdlRect := SDL_Rect new autoRelease; yourself.

	sdlRenderer := window backendWindow renderer sdlRenderer.
	logicalWindowRectangle := 0@0 extent: window extent.

	textureExtent := window canvasExtent.
	texture := sdlRenderer
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888
		access: SDL_TEXTUREACCESS_STREAMING
		width: textureExtent x
		height: textureExtent y
]

{ #category : #initialization }
BlOSWindowSDL2HostSpace >> initializeWithAttributes: initialAttributes [

	window := OSWindow createWithAttributes: initialAttributes.
	window eventHandler:
		(BlOSWindowEventHandler
			window: self
			time: space time
			keyboardKeyTable: keyboardKeyTable).
	window startTextInput.
	window newBlocRenderer
]

{ #category : #'dirty areas' }
BlOSWindowSDL2HostSpace >> invalidate [
	
	window := nil
]

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> isBorderless [

	^ window borderless
]

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> isFullscreen [
	"Return true if an underlying window is in fullscreen mode, false otherwise."

	^ window fullscreen
]

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> isResizable [	
	"Return true if underlying window is resizable, false otherwise"

	^ window resizable
]

{ #category : #'window - text input' }
BlOSWindowSDL2HostSpace >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	^ window isTextInputActive
]

{ #category : #testing }
BlOSWindowSDL2HostSpace >> isValid [

	^ window isNotNil and: [ window isValid ]
]

{ #category : #'host space - testing' }
BlOSWindowSDL2HostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"
	<return: #Boolean>

	^ window isVisible
]

{ #category : #private }
BlOSWindowSDL2HostSpace >> keyboardKeyTable: aKeyboardKeyTable [
	keyboardKeyTable := aKeyboardKeyTable
]

{ #category : #rendering }
BlOSWindowSDL2HostSpace >> lockSurfaceFor: logicalDamagedRectangle scaleFactor: aNumber during: aBlock [

	| physicalDamagedRectangle |
	"Return early if damages fall outside of the space"
	physicalDamagedRectangle :=
		logicalDamagedRectangle intersect: logicalWindowRectangle ifNone: [ ^ self ].
	physicalDamagedRectangle := physicalDamagedRectangle scaleBy: aNumber.

	sdlRect
		x: physicalDamagedRectangle left asInteger;
		y: physicalDamagedRectangle top asInteger;
		w: physicalDamagedRectangle width asInteger;
		h: physicalDamagedRectangle height asInteger.

	(texture
		lockRect: sdlRect
		pixels: pixelsAddress
		pitch: pitchAddress) = 0 ifFalse: [ SDL2 checkForError ].

	renderer
		renderWith: aBlock
		pixels: pixelsAddress
		stride: (pitchAddress signedLongAt: 1)
		physicalRectangle: physicalDamagedRectangle
		logicalRectangle: logicalDamagedRectangle.

	texture unlock.

	"No need to clear the renderer as texture is opaque and covers all pixels"
	sdlRenderer copy: texture; present
]

{ #category : #'host space - geometry' }
BlOSWindowSDL2HostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ window extent asLogicalSize
]

{ #category : #'host space - displaying' }
BlOSWindowSDL2HostSpace >> maximize [
	window maximize
]

{ #category : #'host space - displaying' }
BlOSWindowSDL2HostSpace >> maximized [
	^ window maximized
]

{ #category : #'host space - displaying' }
BlOSWindowSDL2HostSpace >> minimize [
	window minimize
]

{ #category : #'host space - displaying' }
BlOSWindowSDL2HostSpace >> minimized [
	^ window minimized
]

{ #category : #'host space - geometry' }
BlOSWindowSDL2HostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	^ window canvasExtent asPhysicalSize
]

{ #category : #'host space - geometry' }
BlOSWindowSDL2HostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>

	^ window position
]

{ #category : #'host space - geometry' }
BlOSWindowSDL2HostSpace >> position: aPoint [
	window position: aPoint
]

{ #category : #'host space - rendering' }
BlOSWindowSDL2HostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	OSWindowRenderThread uniqueInstance critical: [ self renderer render: self ]
]

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> resizable: aBoolean [
	window resizable: aBoolean
]

{ #category : #'host space - displaying' }
BlOSWindowSDL2HostSpace >> show [
	window show
]

{ #category : #'window - text input' }
BlOSWindowSDL2HostSpace >> startTextInput [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."
	window startTextInput
]

{ #category : #'window - text input' }
BlOSWindowSDL2HostSpace >> startTextInputAtRectangle: aRectangle [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	window startTextInputAtRectangle: aRectangle
]

{ #category : #'window - text input' }
BlOSWindowSDL2HostSpace >> stopTextInput [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	window startTextInput
]

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ window title
]

{ #category : #'window - properties' }
BlOSWindowSDL2HostSpace >> title: aString [
	"Change window's title"

	window title: aString
]

{ #category : #'host space - geometry' }
BlOSWindowSDL2HostSpace >> windowExtent: newExtent [
	"Change window size to a newExtent"

	self logicalSize asPoint ~= newExtent
		ifTrue: [ window extent: newExtent ]
]
