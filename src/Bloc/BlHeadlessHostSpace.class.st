"
I am a fallback host space that is chosen if there are no other available and supported hosts.
"
Class {
	#name : #BlHeadlessHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace + TBlDebug',
	#classTraits : 'TBlHostSpace classTrait + TBlDebug classTrait',
	#instVars : [
		'eventFetcher',
		'host',
		'space',
		'position',
		'title'
	],
	#category : #'Bloc-Universe'
}

{ #category : #'window - properties' }
BlHeadlessHostSpace >> borderless [
	"Return true if underlying window is now borderless, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> canvasExtent [
	"Return a window canvas size in user coordinates.
	This size may differ from the window size on high dpi (retina) screens.
	In most cases canvas is x2 larger than window in pixel on retina screens."
	<return: #Point>

	^ 0@0
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> close [
	"do nothing"
]

{ #category : #'host space - cursor' }
BlHeadlessHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'host space - events' }
BlHeadlessHostSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"
	<return: #BlHostEventFetcher>

	^ eventFetcher
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> fullscreen [
	"Return true if an underlying window is in fullscreen mode,
	false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> fullscreen: aBoolean [
	"Switch underlying window to fullscreen if true is given
	and exit fullscreen mode if false is given"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> hide [
	"do nothing"
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> host [
	"Return a host that was used to create this host space"
	<return: #BlHost>

	^ host
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> host: aBlHost [
	"Assign a host that was used to create this host space"
	
	host := aBlHost
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> icon: aForm [
	"Change window's icon to the given one"
]

{ #category : #initialization }
BlHeadlessHostSpace >> initialize [
	super initialize.
	
	eventFetcher := BlHostEventFetcher new
]

{ #category : #'host space - testing' }
BlHeadlessHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"
	<return: #Boolean>

	^ false
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> maximize [
	"do nothing"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> maximized [

	^ false
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> minimize [
	"do nothing"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> minimized [

	^ false
]

{ #category : #'host space - testing' }
BlHeadlessHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	<return: #Boolean>
	
	^ false
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> open [
	"do nothing"
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ position
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	position := aPoint

]

{ #category : #'host space - drawing' }
BlHeadlessHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> renderer [
	"Return host renderer used to render spaces"
	<return: #TBlHostRenderer>

	^ self shouldNotImplement
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> resizable [
	"Return true if underlying window is resizable, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> resizable: aBoolean [
	"Make underlying window resizable if true is given"
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> scaleFactor [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	^ 1.0 asPoint
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> show [
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> space [
	"Return a space I am assigned to"
	<return: #BlSpace>

	^ space
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> space: aSpace [
	"Assign me to a given space"

	space := aSpace
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ title
]

{ #category : #'window - properties' }
BlHeadlessHostSpace >> title: aString [
	"Change window's title"

	title := aString
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> toBack [
	"do nothing"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> toFront [
	"do nothing"
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>

	^ 0@0
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> windowExtent: anExtent [
	
]
