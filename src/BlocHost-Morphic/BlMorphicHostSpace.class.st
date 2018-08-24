"
I am a host space created by BlMorphicHost.
I make it possible to embed Bloc space within arbitrary morphs.
For more information and example, please refer to BlMorphicHost.
"
Class {
	#name : #BlMorphicHostSpace,
	#superclass : #Object,
	#traits : 'TBlHostSpace',
	#classTraits : 'TBlHostSpace classTrait',
	#instVars : [
		'morph',
		'renderer',
		'host',
		'space',
		'eventFetcher',
		'mutex'
	],
	#category : 'BlocHost-Morphic-Host'
}

{ #category : #'window - properties' }
BlMorphicHostSpace >> borderless [
	"Return true if underlying window is now borderless, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> borderless: aBoolean [
	"Make host window borderless if true is given"
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> canvasExtent [
	"Return a window canvas size in user coordinates.
	This size may differ from the window size on high dpi (retina) screens.
	In most cases canvas is x2 larger than window in pixel on retina screens."
	<return: #Point>

	^ self windowExtent
]

{ #category : #'host space - displaying' }
BlMorphicHostSpace >> close [
	self host containerMorph removeMorph: self morph
]

{ #category : #'host space - cursor' }
BlMorphicHostSpace >> cursor: aCursorForm [
	"Change current cursor image/view to the given one"
	World currentHand showTemporaryCursor: aCursorForm
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ 96.0
]

{ #category : #accessing }
BlMorphicHostSpace >> eventFetcher [
	"Return event fetcher used to enqueue events that should be
	processed in the beginning of every frame"
	<return: #BlHostEventFetcher>

	^ eventFetcher
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> host [
	"Return a host that was used to create this host space"
	<return: #BlHost>

	^ host
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> host: aBlHost [
	"Assign a host that was used to create this host space"
	
	host := aBlHost
]

{ #category : #initialization }
BlMorphicHostSpace >> initialize [
	super initialize.

	mutex := Mutex new.
	eventFetcher := BlHostEventFetcher new
]

{ #category : #accessing }
BlMorphicHostSpace >> lock [
	^ mutex
]

{ #category : #accessing }
BlMorphicHostSpace >> morph [
	^ morph
]

{ #category : #accessing }
BlMorphicHostSpace >> morph: aMorph [
	morph := aMorph.
	aMorph hostSpace: self
]

{ #category : #'host space - displaying' }
BlMorphicHostSpace >> open [
	self show
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> position [
	"Return window's position in screen coordinates"
	<return: #Point>
	
	^ self morph position
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> position: aPoint [
	"Change window's position to a given point in screen coordinates"
	
	self morph position: aPoint

]

{ #category : #'host space - rendering' }
BlMorphicHostSpace >> presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas [
	morph form: aBlHostRendererFormSurface form
]

{ #category : #'host space - rendering' }
BlMorphicHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	self lock critical: [ renderer render: aSpace ]
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> renderer [
	"Return host renderer used to render spaces"
	<return: #TBlHostRenderer>

	^ renderer
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> scaleFactor [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	^ 1.0 asPoint
]

{ #category : #'host space - displaying' }
BlMorphicHostSpace >> show [
	self morph position: self host containerMorph position.
	self host containerMorph addMorphBack: self morph
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> space [
	"Return a space I am assigned to"
	<return: #BlSpace>

	^ space
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> space: aSpace [
	"Assign me to a given space"

	space := aSpace
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> title [
	"Return window's title as a string"
	<return: #String>

	^ ''
]

{ #category : #'window - properties' }
BlMorphicHostSpace >> title: aString [
	"Change window's title"
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>

	^ morph extent
]

{ #category : #'host space - accessing' }
BlMorphicHostSpace >> windowExtent: anExtent [
	morph extent: anExtent
]

{ #category : #'instance creation' }
BlMorphicHostSpace >> withSpartaRenderer [

	renderer := BlSpartaRenderer new.
	renderer initializeHostSpace: self
]
