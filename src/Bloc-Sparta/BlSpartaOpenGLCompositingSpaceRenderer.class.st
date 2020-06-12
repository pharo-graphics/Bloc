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
	| start result |
	
	start := DateAndTime now.
	
	result := aBlock value.
	
	"NonInteractiveTranscript stdout
		nextPutAll: aName; space;
		nextPutAll: ((DateAndTime now - start) asMicroseconds / 1000.0) asString, 'ms'; cr.".
		
	^ result
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
	
	aSpace telemetry
		timeSync: 'Render space'
		during: [
			elementsToRepaint := aSpace elementsNeedingPaint collect: [ :eachElement | eachElement -> eachElement compositionDepth ] as: Array.
			elementsToRepaint sort: [ :a :b | a value > b value ].
			
			aSpace telemetry
				timeSync: 'Repaint'
				during: [
					elementsToRepaint
						collect: [ :eachAssociation | eachAssociation key ]
						thenDo: [ :eachElement |
							aSpace telemetry
								timeSync: [ 'Paint ', eachElement class asString ]
								during: [
									(eachElement shouldBePainted and: [ eachElement isAttachedToSceneGraph ])
										ifTrue: [
											eachElement hasCompositionLayer
												ifTrue: [ BlCompositionPainter repaintCompositedElement: eachElement ]
												ifFalse: [ eachElement markSkippedPaint ] ] ] ] ].

			aRootLayer := aSpace root hasCompositionLayer
				ifTrue: [ aSpace root compositionLayer ]
				ifFalse: [
					aSpace telemetry
						timeSync: 'Repaint root'
						during: [ BlCompositionPainter repaintCompositedElement: aSpace root ]  ].
	
			aRootLayer computeNeedsComposition.
			
			aSpace telemetry
				timeSync: 'As Skia layer'
				during: [ skiaLayer := aRootLayer asSkiaLayer ].
				
			aRootLayer cleanNeedsCompositionFromAllLayers.
				
			aSpace telemetry
				timeSync: 'Draw'
				during: [	
					spartaCanvas surfaceCanvas clear: Color transparent.
					spartaCanvas transform
						by: [ :t | t scaleBy: scaleFactor asPoint ]
						during: [ compositor draw: skiaLayer on: spartaCanvas ]. ].
			
			aSpace telemetry
				timeSync: 'Flush'
				during: [ spartaCanvas flush ] ].
	
	self logCr.
	
	^ (self damagedAreasOf: aSpace)
]
