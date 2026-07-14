"
I am a concrete implementation of a Host Space.
I am headless and mostly used for testing
"
Class {
	#name : #BlHeadlessHostSpace,
	#superclass : #BlHostSpace,
	#instVars : [
		'physicalSize',
		'opened',
		'borderless',
		'eventFetcher'
	],
	#category : #'Bloc-Universe - Host Headless'
}

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> borderless [
	"Return true if underlying window is now without borders,
	false otherwise"
	<return: #Boolean>

	^ borderless
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"

	borderless := aBoolean
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> canvasExtent: anExtent [
	physicalSize := (anExtent x @ anExtent y) asPhysicalSize
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> close [
	opened := false.
	self hide
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> densityDpi [
	"Return screen density as dots per inch.
	Note: on retina displays it is usually 192 (96 * 2)"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'host space - events' }
BlHeadlessHostSpace >> enqueueEvent: aBlEvent [
	eventFetcher enqueueEvent: aBlEvent
]

{ #category : #'host space - events' }
BlHeadlessHostSpace >> fetchedEventsDo: aBlock [
	eventFetcher fetchedEventsDo: aBlock
]

{ #category : #'host space - events' }
BlHeadlessHostSpace >> hasEvents [
	^ eventFetcher isEmpty not
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> hide [
	opened ifFalse: [ ^ self ].
	self space dispatchEvent: BlSpaceHiddenEvent new
]

{ #category : #initialization }
BlHeadlessHostSpace >> initialize [
	super initialize.
	
	physicalSize := 800@600 asPhysicalSize.
	opened := false.
	borderless := false.
	eventFetcher := BlHostEventFetcher hostSpace: self
]

{ #category : #'host space - testing' }
BlHeadlessHostSpace >> isVisible [
	"Return true if underlying window is shown to the user
	(is not minimized or hidden), false otherwise"
	<return: #Boolean>

	^ opened
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Coordinates of the logical size are represented in logical pixels.
	Logical size doesn't necessarily match the physical size, for example on high-DPI displays
	the logical size is scaled down"
	<return: #BlLogicalSize>

	^ physicalSize asLogicalSize
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> maximize [
	
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> minimized [
	^ false
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> physicalSize [
	"Return a physical host space size in screen coordinates.
	(usually differs from logical size on high-dpi (retina) screens)"
	<return: #BlPhysicalSize>

	^ physicalSize
]

{ #category : #'host space - rendering' }
BlHeadlessHostSpace >> render: aSpace [
	"Render a given space on my underlying window or surface.
	I am sent every time space needs to be rendered, which is usually
	at 60 frames per second"
	
	"Does nothing"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> show [
	opened ifTrue: [ ^ self ].
	opened := true.
	self space dispatchEvent: BlSpaceShownEvent new
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ 'Mocked host space'
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> title: aString [
	"Change window's title"
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> toBack [
]

{ #category : #'host space - displaying' }
BlHeadlessHostSpace >> toFront [
]

{ #category : #'host space - accessing' }
BlHeadlessHostSpace >> windowExtent: anExtent [
	physicalSize := (anExtent x @ anExtent y) asPhysicalSize
]
