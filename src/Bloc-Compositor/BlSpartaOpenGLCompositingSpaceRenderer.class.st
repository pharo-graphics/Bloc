Class {
	#name : #BlSpartaOpenGLCompositingSpaceRenderer,
	#superclass : #BlSpartaSpaceRenderer,
	#instVars : [
		'compositor',
		'rootLayer'
	],
	#category : #'Bloc-Compositor-Painter'
}

{ #category : #rendering }
BlSpartaOpenGLCompositingSpaceRenderer >> damagedAreasOf: aSpace [
	^ { 0@0 extent: aSpace extent }
]

{ #category : #initialization }
BlSpartaOpenGLCompositingSpaceRenderer >> initializeForSurface: aSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |

	aSpartaCanvas := (BlSpartaRenderer pickCanvasForSurface: aSurface) forOpenGLOn: aSurface.
	self
		initializeCanvas: aSpartaCanvas
		surface: aSurface.
		
	compositor ifNotNil: #release.
	compositor := SkiaCompositor workers: 1"accelerated: (GlutinEventsFetcher default eventLoop) windowedContext: aSurface context workers: 6".
	rootLayer := BlCompositionContainerLayer new.
]

{ #category : #rendering }
BlSpartaOpenGLCompositingSpaceRenderer >> renderSpace: aSpace [
	"Render a space and return a collection of damaged rectangles"
	<return: #Collection of: #Rectangle>

	self isValid
		ifFalse: [ ^ self ].
		
	compositor
		ifNil: [ ^ self ].
	
	compositor isNull
		ifTrue: [ ^ self ].

	rootLayer removeAllLayers.
	
	spartaCanvas transform
		by: [ :t | t scaleBy: scaleFactor asPoint ]
		during: [
			| painter skiaLayer |

			painter := BlCompositionPainter new bounds: (0@0 extent: aSpace extent).
			painter containerLayer: rootLayer.
			
			aSpace root fullPaintOn: painter offset: 0@0.
			painter stopRecording.

			skiaLayer := rootLayer asSkiaLayer.

			compositor draw: skiaLayer on: spartaCanvas.
			skiaLayer release.
		].

	spartaCanvas flush.
	
	^ (self damagedAreasOf: aSpace)
]
