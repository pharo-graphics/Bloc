"
I am a concrete implementation of a BlHostSpace.
My responsibility is to control OSWindow window using unified host space api.
"
Class {
	#name : #BlOSWindowHostSpace,
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
BlOSWindowHostSpace >> borderless: aBoolean [
	window borderless: aBoolean
]

{ #category : #'window - properties' }
BlOSWindowHostSpace >> center [
	window center
]

{ #category : #'host space - displaying' }
BlOSWindowHostSpace >> close [

	self isValid ifTrue: [ window destroy ].

	window := nil
]

{ #category : #'host space - cursor' }
BlOSWindowHostSpace >> cursor: aCursor [

	window setMouseCursor: aCursor
]

{ #category : #'host space - geometry' }
BlOSWindowHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch (a float)"
	
	^ 96.0
]

{ #category : #'host space - events' }
BlOSWindowHostSpace >> enqueueEvent: aBlEvent [
	"I put events in a queue to be processed later"

	self eventFetcher enqueueEvent: aBlEvent
]

{ #category : #'host space - accessing' }
BlOSWindowHostSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"

	^ eventFetcher
]

{ #category : #'host space - events' }
BlOSWindowHostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
	
	self eventFetcher fetchedEventsDo: aBlock
]

{ #category : #'window - properties' }
BlOSWindowHostSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"

	window fullscreen: aBoolean
]

{ #category : #'host space - displaying' }
BlOSWindowHostSpace >> hide [
	window hide
]

{ #category : #initialization }
BlOSWindowHostSpace >> initialize [

	super initialize.

	eventFetcher := BlHostEventFetcher hostSpace: self
]

{ #category : #initialization }
BlOSWindowHostSpace >> initializeWithAttributes: initialAttributes [

	self
		assert: [ window isNil or: [ window isValid not ] ]
		description: [ 'Window must be nil or invalid' ].

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
BlOSWindowHostSpace >> invalidate [
	
	window := nil
]

{ #category : #'window - properties' }
BlOSWindowHostSpace >> isBorderless [

	^ window borderless
]

{ #category : #'window - properties' }
BlOSWindowHostSpace >> isFullscreen [
	"Return true if an underlying window is in fullscreen mode, false otherwise."

	^ window fullscreen
]

{ #category : #'window - properties' }
BlOSWindowHostSpace >> isResizable [	
	"Return true if underlying window is resizable, false otherwise"

	^ window resizable
]

{ #category : #'window - text input' }
BlOSWindowHostSpace >> isTextInputActive [
	"Check whether or not Unicode text input events are enabled"
	^ window isTextInputActive
]

{ #category : #testing }
BlOSWindowHostSpace >> isValid [
	^ window isNotNil and: [ window isValid ]
]

{ #category : #'host space - testing' }
BlOSWindowHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"
	<return: #Boolean>

	^ window isVisible
]

{ #category : #private }
BlOSWindowHostSpace >> keyboardKeyTable: aKeyboardKeyTable [
	keyboardKeyTable := aKeyboardKeyTable
]

{ #category : #'host space - geometry' }
BlOSWindowHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ window extent asLogicalSize
]

{ #category : #'host space - displaying' }
BlOSWindowHostSpace >> maximize [
	window maximize
]

{ #category : #'host space - displaying' }
BlOSWindowHostSpace >> maximized [
	^ window maximized
]

{ #category : #'host space - displaying' }
BlOSWindowHostSpace >> minimize [
	window minimize
]

{ #category : #'host space - displaying' }
BlOSWindowHostSpace >> minimized [
	^ window minimized
]

{ #category : #'host space - testing' }
BlOSWindowHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	
	^ self isValid not
]

{ #category : #'host space - displaying' }
BlOSWindowHostSpace >> open [
	window show
]

{ #category : #'host space - geometry' }
BlOSWindowHostSpace >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	^ window canvasExtent asPhysicalSize
]

{ #category : #'host space - geometry' }
BlOSWindowHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>

	^ window position
]

{ #category : #'host space - geometry' }
BlOSWindowHostSpace >> position: aPoint [
	window position: aPoint
]

{ #category : #'host space - rendering' }
BlOSWindowHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	OSWindowRenderThread uniqueInstance critical: [ self renderer render: self ]
]

{ #category : #'window - properties' }
BlOSWindowHostSpace >> resizable: aBoolean [
	window resizable: aBoolean
]

{ #category : #'host space - displaying' }
BlOSWindowHostSpace >> show [
	window show
]

{ #category : #'window - text input' }
BlOSWindowHostSpace >> startTextInput [
	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."
	window startTextInput
]

{ #category : #'window - text input' }
BlOSWindowHostSpace >> startTextInputAtRectangle: aRectangle [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	window startTextInputAtRectangle: aRectangle
]

{ #category : #'window - text input' }
BlOSWindowHostSpace >> stopTextInput [

	"Start accepting Unicode text input events.
	I will start accepting Unicode text input events in the focused window, and start emitting text input and text editing events.
	Please use me in pair with stopTextInput.
	On some platforms I may activate the screen keyboard."

	window startTextInput
]

{ #category : #'window - properties' }
BlOSWindowHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ window title
]

{ #category : #'window - properties' }
BlOSWindowHostSpace >> title: aString [
	"Change window's title"

	window title: aString
]

{ #category : #'host space - geometry' }
BlOSWindowHostSpace >> windowExtent: newExtent [
	"Change window size to a newExtent"

	self logicalSize asPoint ~= newExtent
		ifTrue: [ window extent: newExtent ]
]
