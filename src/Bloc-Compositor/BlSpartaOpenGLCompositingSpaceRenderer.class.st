Class {
	#name : #BlSpartaOpenGLCompositingSpaceRenderer,
	#superclass : #BlSpartaSpaceRenderer,
	#instVars : [
		'compositor'
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
	compositor := SkiaCompositor accelerated: (GlutinEventsFetcher default eventLoop) windowedContext: aSurface context workers: 6
]

{ #category : #rendering }
BlSpartaOpenGLCompositingSpaceRenderer >> renderSpace: aSpace [
	"Render a space and return a collection of damaged rectangles"
	<return: #Collection of: #Rectangle>
	| start |
	
	start := DateAndTime now.
	
	self isValid
		ifFalse: [ ^ self ].
		
	compositor
		ifNil: [ ^ self ].
	
	compositor isNull
		ifTrue: [ ^ self ].

	spartaCanvas transform
		by: [ :t | t scaleBy: scaleFactor asPoint ]
		during: [
			| rootLayer painter skiaLayer |
			rootLayer := BlCompositionContainerLayer new.
			painter := BlCompositionPainter new bounds: (0@0 extent: aSpace extent).
			painter containerLayer: rootLayer.
			
			aSpace root fullPaintOn: painter offset: 0@0.
			painter stopRecording.

			skiaLayer := rootLayer asSkiaLayer.
			compositor draw: skiaLayer on: spartaCanvas.
			skiaLayer release.
		].

	spartaCanvas flush.
	
	NonInteractiveTranscript stdout
		nextPutAll: 'Render done! ';
		nextPutAll: ((DateAndTime now - start) asMicroseconds / 1000.0) asString;
		nextPutAll: 'ms';
		cr.
	
	^ (self damagedAreasOf: aSpace)
]
