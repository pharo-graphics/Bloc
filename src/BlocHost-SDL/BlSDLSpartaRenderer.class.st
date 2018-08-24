Class {
	#name : #BlSDLSpartaRenderer,
	#superclass : #Object,
	#traits : 'TBlHostRenderer',
	#classTraits : 'TBlHostRenderer classTrait',
	#instVars : [
		'dirtyAreas',
		'presentNeeded',
		'sdlSpace',
		'sdlRenderer',
		'spartaCanvas',
		'session',
		'texture',
		'pixels',
		'pitch',
		'sdlSurface',
		'textureExtent',
		'surfaceForm',
		'scaleFactor'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : 'BlocHost-SDL'
}

{ #category : #'instance creation' }
BlSDLSpartaRenderer class >> for: anSDLSpace [
	^ self new
		sdlSpace: anSDLSpace;
		sdlRenderer: anSDLSpace sdlWindow createDefaultRenderer;
		resetResources
]

{ #category : #'session management' }
BlSDLSpartaRenderer >> checkSession [
	session == Smalltalk session 
		ifFalse: [ self error: 'Cannot use this renderer (created in a previous session or in a closed window)' ].
]

{ #category : #private }
BlSDLSpartaRenderer >> createSDLSurfaceWithExtent: extent [
	surfaceForm ifNotNil: [ surfaceForm destroySurface ].
	sdlSurface := SDL2 createRGBSurfaceForCairoWidth: extent x height: extent y.
	surfaceForm := SpartaExternalForm extent: extent depth: 32 bits: sdlSurface pixels.
]

{ #category : #initialize }
BlSDLSpartaRenderer >> destroy [
	sdlSpace := nil.
	spartaCanvas := nil.
	session := nil.
	sdlSurface := nil.
	texture := nil.
	sdlRenderer := nil.
]

{ #category : #accessing }
BlSDLSpartaRenderer >> doRender: aSpace [
	| aWindowScale |
	"collect the dirty area to be updated"
	dirtyAreas := aSpace dirtyAreas 
			collect: [ :each | each intersect: (0@0 extent: self sdlSpace windowExtent) ifNone: [ nil ] ]
			thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].
	
	dirtyAreas ifEmpty: [
		"If the window was exposed, present could be still needed."
		presentNeeded ifTrue: [
			self
				prepareForDrawing;
				present ].
		presentNeeded := false.
		^ self ].
	
	"Damaged rectangles are defined in user coordinates (bloc space).
	We have to convert damage to window space, since we want to support high dpi displays"
	aWindowScale := self scaleFactor.
	dirtyAreas := dirtyAreas collect: [ :aRectangle | aRectangle scaleBy: aWindowScale ].
	
	self drawDuring: [:aCanvas| aSpace fullDrawOn: aCanvas ].
	
	self
		presentAreas: dirtyAreas;
		present.
	presentNeeded := false.
]

{ #category : #drawing }
BlSDLSpartaRenderer >> drawDuring: aBlock [
	self prepareForDrawing.
	aBlock value: self spartaCanvas
]

{ #category : #'updating screen' }
BlSDLSpartaRenderer >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different dpi,
	e.g. from normal display to retina"
	<return: #Boolean>

	^ textureExtent ~= sdlSpace rendererExtent
]

{ #category : #initialization }
BlSDLSpartaRenderer >> initialize [

	super initialize.
	session := Smalltalk session.
	spartaCanvas := nil.
	sdlSurface := nil.
	texture := nil.
	sdlRenderer := nil.
	self presentNeeded.
]

{ #category : #accessing }
BlSDLSpartaRenderer >> pitch [
	^ pitch
]

{ #category : #accessing }
BlSDLSpartaRenderer >> pitch: anObject [
	pitch := anObject
]

{ #category : #accessing }
BlSDLSpartaRenderer >> pixels [
	^ pixels
]

{ #category : #accessing }
BlSDLSpartaRenderer >> pixels: anObject [
	pixels := anObject
]

{ #category : #drawing }
BlSDLSpartaRenderer >> prepareForDrawing [
	self hasResized
		ifTrue: [ self resized ]
]

{ #category : #'renderer - rendering' }
BlSDLSpartaRenderer >> prepareToRender: aSpace [
	self prepareForDrawing
]

{ #category : #rendering }
BlSDLSpartaRenderer >> present [
	self validate ifFalse: [ ^ self ].
	sdlRenderer
		clear;
		copy: texture;
		present
]

{ #category : #'updating screen' }
BlSDLSpartaRenderer >> presentAreas: allDamage [
	| pitchHolder externalForm intersection |
	self validate
		ifFalse: [ ^ self ].
		
	pixels := ExternalAddress new.
	pitchHolder := ExternalAddress allocate: 4.
	[
		texture lockPixels: pixels pitch: pitchHolder.
		pitch := pitchHolder signedLongAt: 1.
	] ensure: [ pitchHolder free ].
	
	[
		externalForm := SpartaExternalForm extent: textureExtent depth: 32 bits: pixels.
		allDamage do: [ :rectangle |
			intersection := rectangle
				intersect: (0 @ 0 corner: sdlSpace rendererExtent)
				ifNone: [ nil ].
		
			intersection ifNotNil: [
				self primitiveUpdateRectangle: rectangle externalForm: externalForm.
			]
		].
	] ensure: [
		texture unlock.
		externalForm destroySurface
	].

]

{ #category : #accessing }
BlSDLSpartaRenderer >> presentNeeded [
	presentNeeded := true.
]

{ #category : #accessing }
BlSDLSpartaRenderer >> presentNeeded: anObject [
	presentNeeded := anObject
]

{ #category : #private }
BlSDLSpartaRenderer >> primitiveUpdateRectangle: rectangle externalForm: externalForm [
	externalForm copy: rectangle from: surfaceForm to: rectangle origin rule: Form over
]

{ #category : #'updating resources' }
BlSDLSpartaRenderer >> resetResources [
	| windowSize extent |
	self checkSession.

	windowSize := self sdlSpace windowExtent.
	extent := self sdlSpace rendererExtent.
	scaleFactor := (extent / windowSize) asFloatPoint.
	SDL2 glSetSwapInterval: 1.
	self createSDLSurfaceWithExtent: extent.
	
	spartaCanvas := MozCanvas
		createForData: sdlSurface pixels
		type: MozBackendType SKIA
		extent: extent
		stride: sdlSurface pitch
		format: MozSurfaceFormat B8G8R8A8.
	spartaCanvas transform
			scaleBy: scaleFactor;
			apply.

	texture := sdlRenderer 
		createTextureFormat: SDL_PIXELFORMAT_XRGB8888 
		access: SDL_TEXTUREACCESS_STREAMING 
		width: extent x 
		height: extent y.
		
	textureExtent := extent.
]

{ #category : #'updating screen' }
BlSDLSpartaRenderer >> resized [
	self resetResources.
	self updateAll
]

{ #category : #accessing }
BlSDLSpartaRenderer >> scaleFactor [
	^ scaleFactor ifNil: [
		(self sdlSpace rendererExtent / self sdlSpace windowExtent) asFloatPoint ]
]

{ #category : #accessing }
BlSDLSpartaRenderer >> sdlRenderer [
	^ sdlRenderer
]

{ #category : #accessing }
BlSDLSpartaRenderer >> sdlRenderer: anObject [
	sdlRenderer := anObject
]

{ #category : #accessing }
BlSDLSpartaRenderer >> sdlSpace [
	^ sdlSpace
]

{ #category : #accessing }
BlSDLSpartaRenderer >> sdlSpace: anObject [
	sdlSpace := anObject
]

{ #category : #accessing }
BlSDLSpartaRenderer >> sdlSurface [
	^ sdlSurface
]

{ #category : #accessing }
BlSDLSpartaRenderer >> sdlSurface: anObject [
	sdlSurface := anObject
]

{ #category : #accessing }
BlSDLSpartaRenderer >> session [
	^ session
]

{ #category : #accessing }
BlSDLSpartaRenderer >> session: anObject [
	session := anObject
]

{ #category : #accessing }
BlSDLSpartaRenderer >> spartaCanvas [
	^ spartaCanvas
]

{ #category : #accessing }
BlSDLSpartaRenderer >> spartaCanvas: anObject [
	spartaCanvas := anObject
]

{ #category : #accessing }
BlSDLSpartaRenderer >> surfaceForm [
	^ surfaceForm
]

{ #category : #accessing }
BlSDLSpartaRenderer >> surfaceForm: anObject [
	surfaceForm := anObject
]

{ #category : #accessing }
BlSDLSpartaRenderer >> texture [
	^ texture
]

{ #category : #accessing }
BlSDLSpartaRenderer >> texture: anObject [
	texture := anObject
]

{ #category : #accessing }
BlSDLSpartaRenderer >> textureExtent [
	^ textureExtent
]

{ #category : #accessing }
BlSDLSpartaRenderer >> textureExtent: anObject [
	textureExtent := anObject
]

{ #category : #'updating screen' }
BlSDLSpartaRenderer >> updateAll [
	self validate ifFalse: [ ^ self ].
	texture updateTexturePixels: sdlSurface pixels pitch: sdlSurface pitch.
]

{ #category : #'updating screen' }
BlSDLSpartaRenderer >> updateRectangle: aRectangle [
	| intersection pitchHolder externalForm |
	self validate ifFalse: [ ^ self ].
	intersection := aRectangle
		intersect: (0 @ 0 corner: textureExtent)
		ifNone: [ ^ self ].
	
	pixels := ExternalAddress new.
	pitchHolder := ExternalAddress allocate: 4.
	[
		texture lockPixels: pixels pitch: pitchHolder.
		pitch := pitchHolder signedLongAt: 1.
	] ensure: [ pitchHolder free ].

	externalForm := SpartaExternalForm extent: textureExtent depth: 32 bits: pixels.
	[
		self primitiveUpdateRectangle: intersection externalForm: externalForm
	] ensure: [
		texture unlock.
		externalForm destroySurface
	].

]

{ #category : #'development support' }
BlSDLSpartaRenderer >> validate [
	self checkSession.
	(texture isNil or: [ texture isNull ]) ifTrue: [ ^ false ].	
	sdlSpace rendererExtent ~= textureExtent ifTrue: [ ^ false ].
	^ true
]
