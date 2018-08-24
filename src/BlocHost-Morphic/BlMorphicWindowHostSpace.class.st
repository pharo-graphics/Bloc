"
I am a concrete implementation of a BlHostSpace.
My responsibility is to control morphic window using unified host space api.

Depends on Bloc-Sparta
"
Class {
	#name : #BlMorphicWindowHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace',
	#classTraits : 'TBlHostSpace classTrait',
	#instVars : [
		'morphicWindow',
		'mirrowWindows',
		'renderer',
		'mutex',
		'eventFetcher',
		'space',
		'host'
	],
	#category : 'BlocHost-Morphic-Host'
}

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> canvasExtent [
	^ self windowExtent
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> close [
	morphicWindow close
]

{ #category : #'host space - cursor' }
BlMorphicWindowHostSpace >> cursor: aCursorForm [
	"Change current cursor image/view to the given one"
	World currentHand showTemporaryCursor: aCursorForm
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #'host space - events' }
BlMorphicWindowHostSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"
	<return: #BlHostEventFetcher>

	^ eventFetcher
]

{ #category : #'host space - testing' }
BlMorphicWindowHostSpace >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different dpi,
	e.g. from normal display to retina"
	<return: #Boolean>

	^ false
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> host [
	"Return a host that was used to create this host space"
	<return: #BlHost>

	^ host
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> host: aBlHost [
	"Assign a host that was used to create this host space"
	
	host := aBlHost
]

{ #category : #initialization }
BlMorphicWindowHostSpace >> initialize [
	super initialize.

	eventFetcher := BlHostEventFetcher new.
	mutex := Mutex new.
	mirrowWindows := OrderedCollection new
]

{ #category : #'private - accessing' }
BlMorphicWindowHostSpace >> lock [
	^ mutex
]

{ #category : #'private - accessing' }
BlMorphicWindowHostSpace >> mirrowWindow: aWindow [
	
	mirrowWindows add: aWindow.
	aWindow hostSpace: self
]

{ #category : #'private - accessing' }
BlMorphicWindowHostSpace >> morphicWindow [
	^ morphicWindow
]

{ #category : #'private - accessing' }
BlMorphicWindowHostSpace >> morphicWindow: aWindow [
	morphicWindow := aWindow.
	morphicWindow hostSpace: self
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> open [
	self show
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ morphicWindow position
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> position: aPoint [
	"Change window's position to a given point in screen corrdinates"
	
	morphicWindow position: aPoint
]

{ #category : #'host space - rendering' }
BlMorphicWindowHostSpace >> presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas [

	morphicWindow form: aBlHostRendererFormSurface form.
	mirrowWindows do: [ :each | each form: aBlHostRendererFormSurface form ]
]

{ #category : #'host space - rendering' }
BlMorphicWindowHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	self lock critical: [ renderer render: aSpace ]
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> renderer [
	"Return host renderer used to render spaces"
	<return: #TBlHostRenderer>

	^ renderer
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> scaleFactor [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	^ 1@1
]

{ #category : #'host space - displaying' }
BlMorphicWindowHostSpace >> show [
	| anExtent |
	
	anExtent := morphicWindow extent.
	morphicWindow openInWorld.
	morphicWindow extent: anExtent
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> space [
	"Return a space I am assigned to"
	<return: #BlSpace>

	^ space
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> space: aSpace [
	"Assign me to a given space"

	space := aSpace
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ morphicWindow title
]

{ #category : #'window - properties' }
BlMorphicWindowHostSpace >> title: aString [
	"Change window's title"

	morphicWindow title: aString
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>

	^ morphicWindow spaceExtent
]

{ #category : #'host space - accessing' }
BlMorphicWindowHostSpace >> windowExtent: anExtent [
	morphicWindow spaceExtent: anExtent
]

{ #category : #'instance creation' }
BlMorphicWindowHostSpace >> withSpartaRenderer [

	renderer := BlSpartaRenderer new.
	renderer initializeHostSpace: self
]
