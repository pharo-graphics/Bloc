"
I am a concrete implementation of a BlHostSpace.
My responsibility is to control Gtk3 window using unified host space api 
"
Class {
	#name : #BlGtkSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace',
	#classTraits : 'TBlHostSpace classTrait',
	#instVars : [
		'eventQueue',
		'hostWindow',
		'renderer',
		'windowID'
	],
	#category : 'BlocHost-Gtk'
}

{ #category : #'host space - accessing' }
BlGtkSpace >> borderless [
	^ hostWindow primGetDecorated
]

{ #category : #'host space - accessing' }
BlGtkSpace >> borderless: aBoolean [
	^ hostWindow primSetDecorated: aBoolean not
]

{ #category : #'host space - displaying' }
BlGtkSpace >> close [
	self hostWindowDo: [ :hw | hw primClose. hw primDestroy ].
	renderer := nil.
	hostWindow := nil
]

{ #category : #'host space - cursor' }
BlGtkSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"


	"hostWindow primGetWindow primSetCursor: aGdkCursor"
]

{ #category : #'host space - accessing' }
BlGtkSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>

	^ hostWindow primGetScreen primGetResolution.
]

{ #category : #'host space - events' }
BlGtkSpace >> enqueueEvent: anEvent [

	eventQueue nextPut: anEvent.
	BlUniverse default requestNextPulse
]

{ #category : #'host space - events' }
BlGtkSpace >> fetchedEventsDo: aBlock [
	| events |
	events := LinkedList new.
	eventQueue flush: [ :event | events add: event ].
	events do: aBlock
]

{ #category : #'host space - displaying' }
BlGtkSpace >> fullscreen [
	self shouldBeImplemented 
]

{ #category : #'host space - displaying' }
BlGtkSpace >> fullscreen: aBoolean [
	aBoolean ifTrue: [
		hostWindow primFullscreen
	] ifFalse: [ 
		hostWindow primUnfullscreen
	]
]

{ #category : #'host space - testing' }
BlGtkSpace >> hasResized [
	^ renderer hasResized
]

{ #category : #'host space - displaying' }
BlGtkSpace >> hide [
	hostWindow primIconify 
]

{ #category : #'private - accessing' }
BlGtkSpace >> hostWindow [
	^ hostWindow 
]

{ #category : #'private - accessing' }
BlGtkSpace >> hostWindow: aGtkWindow [
	hostWindow := aGtkWindow.
	windowID := hostWindow primGetWindow handle asInteger 
]

{ #category : #'private - accessing' }
BlGtkSpace >> hostWindowDo: aBlock [
	hostWindow ifNotNil: aBlock
]

{ #category : #'host space - accessing' }
BlGtkSpace >> icon: aForm [
	"Change window icon to the given one"
		
	aForm ifNil: [ ^ self ].
	
	"hostWindow primSetIcon: anIcon"
]

{ #category : #initialization }
BlGtkSpace >> initialize [
	super initialize.
	eventQueue := WaitfreeQueue new
]

{ #category : #'host space - testing' }
BlGtkSpace >> isVisible [
	^ hostWindow primIsVisible
]

{ #category : #'host space - displaying' }
BlGtkSpace >> maximize [
	hostWindow primMaximize
]

{ #category : #'host space - displaying' }
BlGtkSpace >> maximized [
	^ hostWindow primIsMaximized 
]

{ #category : #'host space - displaying' }
BlGtkSpace >> minimize [
	hostWindow primIconify
]

{ #category : #'host space - displaying' }
BlGtkSpace >> minimized [
	^ self shouldBeImplemented
]

{ #category : #'host space - displaying' }
BlGtkSpace >> open [
	hostWindow primShowAll
]

{ #category : #'host space - accessing' }
BlGtkSpace >> position [
	| x y |
	x := ByteArray new: ExternalType ulong byteSize.
	y := ByteArray new: ExternalType ulong byteSize.
	hostWindow primGetPositionX: x y: y.
	^ ( x unsignedLongAt: 1) @ (y unsignedLongAt: 1)
]

{ #category : #'host space - accessing' }
BlGtkSpace >> position: aPoint [
	hostWindow primMoveX: aPoint x asInteger y: aPoint y asInteger
]

{ #category : #'host space - drawing' }
BlGtkSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	renderer render: aSpace
]

{ #category : #'host space - accessing' }
BlGtkSpace >> scaleFactor [
	^ hostWindow  primGetScaleFactor asPoint
]

{ #category : #'host space - displaying' }
BlGtkSpace >> show [
	hostWindow primPresent 
]

{ #category : #'host space - accessing' }
BlGtkSpace >> title [
	^ hostWindow primGetTitle
]

{ #category : #'host space - accessing' }
BlGtkSpace >> title: aTitle [
	hostWindow primSetTitle: aTitle
]

{ #category : #'host space - accessing' }
BlGtkSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels on high dpi (retina) screens.
	Use #extent to get actual pixel size"
   <return: #Point>
	| w h |
	w := ByteArray new: 4.
	h := ByteArray new: 4.
	hostWindow primGetSizeW: w h: h.
	^ (w signedLongAt: 1) @ (h signedLongAt: 1)
]

{ #category : #'host space - accessing' }
BlGtkSpace >> windowExtent: newExtent [
	"Change window size to a newExtent"

	"self windowExtent ~= newExtent
		ifTrue: [ hostWindow primSetSizeRequestW: newExtent x h: newExtent y ]."

	"we must always let renderer now that size changed
	(dpi might changed, even if extent is still the same)"
	renderer resized
]

{ #category : #'private - accessing' }
BlGtkSpace >> windowID [
	^ windowID
]

{ #category : #initialization }
BlGtkSpace >> withSpartaRendereer [
	renderer := BlGtkSpartaRenderer for: self
]
