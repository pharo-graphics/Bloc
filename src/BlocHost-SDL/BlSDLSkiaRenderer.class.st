Class {
	#name : #BlSDLSkiaRenderer,
	#superclass : #Object,
	#traits : 'TBlHostRenderer',
	#classTraits : 'TBlHostRenderer classTrait',
	#instVars : [
		'dirtyAreas',
		'sdlSpace',
		'skiaCanvas',
		'glContext',
		'scaleFactor',
		'drawableExtent'
	],
	#pools : [
		'SDL2Constants'
	],
	#category : 'BlocHost-SDL'
}

{ #category : #'instance creation' }
BlSDLSkiaRenderer class >> for: anSDLSpace [
	^ self new
		sdlSpace: anSDLSpace;
		yourself
]

{ #category : #accessing }
BlSDLSkiaRenderer >> dirtyAreas [
	^ dirtyAreas
]

{ #category : #accessing }
BlSDLSkiaRenderer >> dirtyAreas: aCollection [
	dirtyAreas := aCollection
]

{ #category : #rendering }
BlSDLSkiaRenderer >> doRender: aSpace [
	
	self prepareForDrawing.
	dirtyAreas := aSpace dirtyAreas.
	self drawDuring: [ :aCanvas | aSpace fullDrawOn: aCanvas ].
	self present.
]

{ #category : #drawing }
BlSDLSkiaRenderer >> drawDuring: aBlock [
	"self dirtyAreas do: [ :aRectangle |
		skiaCanvas clip
			by: aRectangle
			during: [ aBlock value: skiaCanvas ] ]."

	aBlock value: skiaCanvas
]

{ #category : #'updating screen' }
BlSDLSkiaRenderer >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different dpi,
	e.g. from normal display to retina"
	<return: #Boolean>

	^ drawableExtent ~= sdlSpace drawableExtent
]

{ #category : #misc }
BlSDLSkiaRenderer >> makeCurrent [
	SDL2 glMakeCurrent: sdlSpace sdlWindow context: glContext
]

{ #category : #rendering }
BlSDLSkiaRenderer >> prepareForDrawing [
	self hasResized
		ifTrue: [ self resized ].
	self makeCurrent.
	SDL2 glClear: 16384
]

{ #category : #'renderer - rendering' }
BlSDLSkiaRenderer >> prepareToRender: aSpace [
	self prepareForDrawing
]

{ #category : #drawing }
BlSDLSkiaRenderer >> present [
	
	skiaCanvas flush.
	self swapBuffers
]

{ #category : #'updating resources' }
BlSDLSkiaRenderer >> resetResources [
	| windowExtent |
		
	glContext := SDL2 glCreateContext: sdlSpace sdlWindow handle.

	windowExtent := sdlSpace windowExtent.
	drawableExtent := sdlSpace drawableExtent.

	SDL2 glClearColorR: 1 g: 1 b: 1 a: 1.
	SDL2 glSetSwapInterval: 1.
	
	scaleFactor := (drawableExtent / windowExtent) asFloatPoint.

	skiaCanvas := SkiaCanvas
		extent: windowExtent
		renderExtent: drawableExtent.
	
	skiaCanvas transform
		scaleBy: scaleFactor;
		apply
]

{ #category : #'updating screen' }
BlSDLSkiaRenderer >> resized [
	self resetResources
]

{ #category : #accessing }
BlSDLSkiaRenderer >> scaleFactor [
	^ scaleFactor ifNil: [
		(sdlSpace drawableExtent / sdlSpace windowExtent) asFloatPoint ]
]

{ #category : #accessing }
BlSDLSkiaRenderer >> sdlSpace: aSDLSpace [
	sdlSpace := aSDLSpace.
	self resetResources
]

{ #category : #misc }
BlSDLSkiaRenderer >> swapBuffers [
	SDL2 glSwapWindow: sdlSpace sdlWindow handle
]
