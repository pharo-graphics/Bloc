"
I am a concrete implementation of a BlHostRenderer.

I allow space to be rendered on sparta canvas without making any asumptions about concrete host space type
"
Class {
	#name : #BlSpartaRenderer,
	#superclass : #Object,
	#traits : 'TBlHostRenderer + TBlDebug',
	#classTraits : 'TBlHostRenderer classTrait + TBlDebug classTrait',
	#instVars : [
		'surface',
		'spartaPainer'
	],
	#classInstVars : [
		'defaultCanvasBuilder'
	],
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #accessing }
BlSpartaRenderer class >> availableCanvasBuilderClasses [
	"Return all available sparta canvas builder classes sorted by their priority"
	<return: #Collection>
	
	^ ((BlSpartaCanvasBuilder allSubclasses select: [ :aBuilderClass | aBuilderClass isSupported ])
		select: [ :aBuilderClass | 
			BlHostRendererSurface allSurfaces anySatisfy: [ :aSurface |
				(aSurface supportedBy: aBuilderClass) and: [ aSurface supportedBy: BlUniverse default host ] ] ])
		sort: [ :a :b | a priority < b priority ]
]

{ #category : #accessing }
BlSpartaRenderer class >> defaultCanvasBuilder [
	<return: #BlSpartaCanvasBuilder>

	^ defaultCanvasBuilder ifNil: [ defaultCanvasBuilder := self pickCanvasBuilderClass new ]
]

{ #category : #accessing }
BlSpartaRenderer class >> defaultCanvasBuilder: aCanvasBuilder [
	 defaultCanvasBuilder := aCanvasBuilder
]

{ #category : #accessing }
BlSpartaRenderer class >> pickCanvasBuilderClass [
	"Find a default sparta canvas builder among all available.
	Return a special null one if there are no available builders"
	<return: #'BlSpartaCanvasBuilder class'>

	^ self availableCanvasBuilderClasses
		"There are no availbale builders, return a null one"
		ifEmpty: [ self shouldBeImplemented ]
		ifNotEmpty: [ :theBuilderClasses | theBuilderClasses first ]
]

{ #category : #'renderer - rendering' }
BlSpartaRenderer >> doRender: aSpace dirtyAreas: aCollectionOfRectangles [
	| theDirtyAreas |
	
	self hasResized
		ifTrue: [ self surface initializeOn: self ].
	
	theDirtyAreas := spartaPainer
		render: aSpace
		dirtyAreas: aCollectionOfRectangles.

	self presentAreas: theDirtyAreas
]

{ #category : #'renderer - testing' }
BlSpartaRenderer >> hasResized [
	"Return true if host space resized since previous frame, otherwise false"
	<return: #Boolean>

	^ spartaPainer isNil
		or: [ spartaPainer isValid not
			or: [ self surface physicalSize ~= spartaPainer physicalSize
				or: [ self surface dpiFactor ~= spartaPainer dpiFactor ] ] ]
]

{ #category : #initialization }
BlSpartaRenderer >> initialize [
	super initialize.

	surface := nil
]

{ #category : #initialization }
BlSpartaRenderer >> initializeForBuffer: aBufferSurface [
	"Initalize sparta canvas to be used with a pixel buffer surface"
	| aSpartaCanvas |

	aSpartaCanvas := (self pickCanvasForSurface: aBufferSurface) forBufferOn: aBufferSurface.
	spartaPainer := BlSpartaCanvasPainter new initializeWithCanvas: aSpartaCanvas surface: aBufferSurface.
]

{ #category : #initialization }
BlSpartaRenderer >> initializeForForm: aFormSurface [
	"Initalize sparta canvas to be used with a form surface"
	| aSpartaCanvas |

	aSpartaCanvas := (self pickCanvasForSurface: aFormSurface) forFormOn: aFormSurface.
	spartaPainer := BlSpartaCanvasPainter new initializeWithCanvas: aSpartaCanvas surface: aFormSurface
]

{ #category : #initialization }
BlSpartaRenderer >> initializeForOpenGL: anOpenGLSurface [
	"Asks renderer to initialize itself to be used together with an OpenGL surface"
	| aSpartaCanvas |

	aSpartaCanvas := (self pickCanvasForSurface: anOpenGLSurface) forFormOn: anOpenGLSurface.
	spartaPainer := BlSpartaCanvasPainter new initializeWithCanvas: aSpartaCanvas surface: anOpenGLSurface
]

{ #category : #initialization }
BlSpartaRenderer >> initializeHostSpace: aBlHostSpace [
	| supportedSurfaces theCanvases theSupportedCanvases theBestCanvas |

	supportedSurfaces := BlHostRendererSurface allSurfaces select: [ :aSurfaceClass | aSurfaceClass supportedBy: aBlHostSpace ].
	
	theCanvases := self class availableCanvasBuilderClasses sorted: [ :a :b | a priority < b priority ].

	theSupportedCanvases := theCanvases
		select: [ :eachCanvas | supportedSurfaces anySatisfy: [ :eachSurfaceClass | eachSurfaceClass supportedBy: eachCanvas ] ].

	theSupportedCanvases ifEmpty: [ 
		^ self error: (aBlHostSpace asString, ' does not support any canvas') ].
	
	theBestCanvas := theSupportedCanvases first.
	supportedSurfaces := (supportedSurfaces select: [ :aSurfaceClass | aSurfaceClass supportedBy: theBestCanvas ])
		sort: [ :a :b | a priority < b priority ].

	surface := supportedSurfaces first new.
	surface hostSpace: aBlHostSpace.
	surface initializeOn: aBlHostSpace.
]

{ #category : #initialization }
BlSpartaRenderer >> pickCanvasForSurface: aSurface [
	<return: #BlSpartaCanvasBuilder>
	| theCanvases theSupportedCanvases |
	
	theCanvases := self class availableCanvasBuilderClasses sorted: [ :a :b | a priority < b priority ].
	
	theSupportedCanvases := theCanvases
		select: [ :eachCanvas | aSurface class supportedBy: eachCanvas ].
	
	theSupportedCanvases
		ifEmpty: [ self error: '{1} is not supported by any canvas' ].

	^ theSupportedCanvases first new
]

{ #category : #'renderer - rendering' }
BlSpartaRenderer >> prepareToRender: aSpace [
	"I check if window extent changed since last rendering step and if yes, recreate resources"
]

{ #category : #'renderer - testing' }
BlSpartaRenderer >> supportsBufferSurface [
	"Return true if this renderer can work with buffer surface, false otherwise"
	<return: #Boolean>
	
	^ self class defaultCanvasBuilder class supportsBufferSurface
]

{ #category : #'renderer - testing' }
BlSpartaRenderer >> supportsFormSurface [
	"Return true if this renderer can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ self class defaultCanvasBuilder class supportsFormSurface
]

{ #category : #'renderer - testing' }
BlSpartaRenderer >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ self class defaultCanvasBuilder class supportsOpenGLSurface
]

{ #category : #'renderer - accessing' }
BlSpartaRenderer >> surface [
	^ surface
]

{ #category : #'renderer - accessing' }
BlSpartaRenderer >> surface: aRendererSurface [
	surface := aRendererSurface
]
