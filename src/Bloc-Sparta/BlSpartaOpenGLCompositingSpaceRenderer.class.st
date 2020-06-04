Class {
	#name : #BlSpartaOpenGLCompositingSpaceRenderer,
	#superclass : #BlSpartaHardwareAcceleratedSpaceRenderer,
	#instVars : [
		'compositor',
		'rootLayer'
	],
	#category : #'Bloc-Sparta-Renderer'
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
	compositor := SkiaCompositor new.
	rootLayer := BlCompositionContainerLayer new
]

{ #category : #'as yet unclassified' }
BlSpartaOpenGLCompositingSpaceRenderer >> logCr [
	"NonInteractiveTranscript stdout cr"
]

{ #category : #'as yet unclassified' }
BlSpartaOpenGLCompositingSpaceRenderer >> logTime: aName during: aBlock [
	| start |
	
	start := DateAndTime now.
	
	aBlock value.
	
	"NonInteractiveTranscript stdout
		nextPutAll: aName; space;
		nextPutAll: ((DateAndTime now - start) asMicroseconds / 1000.0) asString, 'ms'; cr."
]

{ #category : #rendering }
BlSpartaOpenGLCompositingSpaceRenderer >> renderSpace: aSpace [
	"Render a space and return a collection of damaged rectangles"
	<return: #Collection of: #Rectangle>
	| skiaLayer elementsToRepaint aRootLayer |

	self isValid
		ifFalse: [ ^ self ].
		
	compositor
		ifNil: [ ^ self ].
	
	compositor isNull
		ifTrue: [ ^ self ].
	
	self
		logTime: '[renderSpace]'
		during: [
			elementsToRepaint := aSpace elementsNeedingPaint collect: [ :eachElement | eachElement -> eachElement compositionDepth ] as: Array.
			elementsToRepaint sort: [ :a :b | a value > b value ].
			
			self
				logTime: '[repaint]'
				during: [
					elementsToRepaint
						collect: [ :eachAssociation | eachAssociation key ]
						thenDo: [ :eachElement |
							self
								logTime: '[', eachElement asString, ']'
								during: [
									(eachElement shouldBePainted and: [ eachElement isAttachedToSceneGraph ])
										ifTrue: [
											eachElement compositionLayer
												ifNil: [ eachElement markSkippedPaint ]
												ifNotNil: [ BlCompositionPainter repaintCompositedElement: eachElement ] ] ] ] ].

			aRootLayer := aSpace root compositionLayer ifNil: [
				self
				logTime: '[repaint root]'
				during: [ BlCompositionPainter repaintCompositedElement: aSpace root. ].
				aSpace root compositionLayer  ].
			
			aRootLayer computeNeedsComposition.
			
			self
				logTime: '[asSkiaLayer]'
				during: [ skiaLayer := aRootLayer asSkiaLayer ].
				
			self
				logTime: '[draw]'
				during: [	
					spartaCanvas surfaceCanvas clear: Color transparent.
					spartaCanvas transform
						by: [ :t | t scaleBy: scaleFactor asPoint ]
						during: [ compositor draw: skiaLayer on: spartaCanvas ]. ].

			self
				logTime: '[flush]'
				during: [ spartaCanvas flush. ].

			self
				logTime: '[release]'
				during: [ skiaLayer release. ].		
		].
	
	self logCr.
	
	^ (self damagedAreasOf: aSpace)
]
