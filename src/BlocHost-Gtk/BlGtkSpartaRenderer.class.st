"
I am a concrete implementation of a BlHostRenderer.
I allow space to be rendered on sparta canvas while being able to display it on on Gtk3 surface.

I use cairo image surface as pixel buffer so that sparta canvas could render directly to it as target surface
"
Class {
	#name : #BlGtkSpartaRenderer,
	#superclass : #Object,
	#traits : 'TBlHostRenderer',
	#classTraits : 'TBlHostRenderer classTrait',
	#instVars : [
		'dirtyAreas',
		'presentNeeded',
		'hostSpace',
		'spartaCanvas',
		'session',
		'cairoContext',
		'cairoSurface',
		'extent',
		'scaleFactor'
	],
	#category : 'BlocHost-Gtk'
}

{ #category : #'instance creation' }
BlGtkSpartaRenderer class >> for: aGtkSpace [
	^ self new
		hostSpace: aGtkSpace;
		resetResources
]

{ #category : #'private - session management' }
BlGtkSpartaRenderer >> checkSession [
	session == Smalltalk session 
		ifFalse: [ self error: 'Cannot use this renderer (created in a previous session or in a closed window)' ].
]

{ #category : #initialization }
BlGtkSpartaRenderer >> createCairoContext [
	^ hostSpace hostWindow primGetWindow primCairoCreate
]

{ #category : #initialization }
BlGtkSpartaRenderer >> createCairoSurfaceWithExtent: anExtent [
	^ hostSpace hostWindow primGetWindow
		primCreateSimilarImageSurfaceFormat: CairoFormatT CAIRO_FORMAT_ARGB32
		w: anExtent x
		h: anExtent y
		scale: 0
]

{ #category : #'renderer - accessing' }
BlGtkSpartaRenderer >> dirtyAreas [
		^ dirtyAreas
]

{ #category : #'renderer - accessing' }
BlGtkSpartaRenderer >> dirtyAreas: aCollection [
	dirtyAreas := aCollection
]

{ #category : #'renderer - rendering' }
BlGtkSpartaRenderer >> doRender: aSpace [

	self prepareForDrawing.
	self drawDuring: [:aCanvas| aSpace fullDrawOn: aCanvas ].
	self present.
	
	self clearDirtyAreasFor: aSpace
]

{ #category : #'private - rendering' }
BlGtkSpartaRenderer >> drawDuring: aBlock [
	aBlock value: self spartaCanvas.
	
]

{ #category : #'private - testing' }
BlGtkSpartaRenderer >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different dpi,
	e.g. from normal display to retina"
	<return: #Boolean>

	^ extent ~= hostSpace windowExtent
]

{ #category : #'private - accessing' }
BlGtkSpartaRenderer >> hostSpace [
	^ hostSpace
]

{ #category : #'private - accessing' }
BlGtkSpartaRenderer >> hostSpace: anObject [
	hostSpace := anObject
]

{ #category : #initialization }
BlGtkSpartaRenderer >> initialize [

	super initialize.
	session := Smalltalk session.
	spartaCanvas := nil.
]

{ #category : #'private - rendering' }
BlGtkSpartaRenderer >> prepareForDrawing [
	 self hasResized
		ifTrue: [ self resized ].
]

{ #category : #'private - rendering' }
BlGtkSpartaRenderer >> present [
	self validate ifFalse: [ ^ self ].

	cairoContext := self createCairoContext.
	cairoSurface := CairoSurfaceT primCreateForData: self spartaCanvas data 
		format: CairoFormatT  CAIRO_FORMAT_ARGB32
		w: self spartaCanvas extent x
		h: self spartaCanvas extent y
		stride: self spartaCanvas stride.

	cairoContext primSetOperator: CairoOperatorT CAIRO_OPERATOR_SOURCE.
	cairoContext primSetSourceSurface: cairoSurface x: 0 y: 0.
	cairoContext primPaint.
	cairoContext primDestroy.
	cairoSurface primDestroy.
	
	"hostSpace hostWindow primQueueDraw"
	
]

{ #category : #'private - rendering' }
BlGtkSpartaRenderer >> presentAreas: allDamage [
	| intersection |
	self validate
		ifFalse: [ ^ self ].
	allDamage do: [ :rectangle | 
		intersection := rectangle intersect: (0 @ 0 corner: hostSpace extent) ifNone: [ nil ].
		intersection ifNotNil: [ 
			"hostSpace hostWindow primGetWindow primInvalidateRect: (GdkRectangle fromRect: intersection) autoRelease"
			hostSpace hostWindow primGetWindow queueDrawArea: intersection
		] 
	]
]

{ #category : #'private - updating resources' }
BlGtkSpartaRenderer >> resetResources [
	
	self checkSession.
	extent := self hostSpace windowExtent.
	scaleFactor := self hostSpace scaleFactor.
	
	spartaCanvas := MozCanvas 
		createExtent: extent
		format: MozSurfaceFormat B8G8R8A8.
		
	spartaCanvas transform
		scaleBy: scaleFactor;
		apply
]

{ #category : #'private - updating resources' }
BlGtkSpartaRenderer >> resized [
	self resetResources
]

{ #category : #'private - accessing' }
BlGtkSpartaRenderer >> scaleFactor [
	^ scaleFactor ifNil: [ self hostSpace scaleFactor ]
]

{ #category : #'private - accessing' }
BlGtkSpartaRenderer >> spartaCanvas [
	^ spartaCanvas
]

{ #category : #'private - rendering' }
BlGtkSpartaRenderer >> updateRectangle: aRectangle [
	"hostSpace hostWindow primGetWindow primInvalidateRect: (GdkRectangle fromRect: aRectangle) autoRelease."

	hostSpace hostWindow primGetWindow queueDrawArea: aRectangle
]

{ #category : #'private - updating resources' }
BlGtkSpartaRenderer >> validate [
	self checkSession.
	hostSpace windowExtent ~= extent ifTrue: [ ^ false ].
	^ true
]
