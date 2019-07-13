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
		'spartaCanvas',
		'session',
		'surface',
		'windowExtent',
		'canvasExtent'
	],
	#classInstVars : [
		'defaultCanvasBuilder'
	],
	#category : 'Bloc-Sparta'
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
	
	self
		assert: [ session == Smalltalk session ]
		description: [ 'Session has been changed! Fix your #prepareToRender: !' ].
	
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Sparta Canvas must be valid at this point!' ].
	
	"collect the dirty area to be updated"
	theDirtyAreas := aCollectionOfRectangles 
		collect: [ :each | each intersect: (0@0 extent: windowExtent) ifNone: [ nil ] ]
		thenSelect: [ :each | each isNotNil and: [ each hasPositiveExtent ] ].

	theDirtyAreas
		ifEmpty: [ ^ self ].

	theDirtyAreas do: [ :aBlBounds | 
		spartaCanvas clip by: aBlBounds during: [ 
			aSpace fullDrawOn: spartaCanvas
		].
	].

	spartaCanvas flush.

	self presentAreas: theDirtyAreas
]

{ #category : #'renderer - testing' }
BlSpartaRenderer >> hasResized [
	"Return true if host space resized since previous frame, otherwise false"
	<return: #Boolean>
	
	^ session ~= Smalltalk session
		or: [ self surface windowExtent ~= windowExtent
			or: [ self surface canvasExtent ~= canvasExtent ] ]
]

{ #category : #initialization }
BlSpartaRenderer >> initialize [
	super initialize.

	spartaCanvas := nil.
	surface := nil
]

{ #category : #initialization }
BlSpartaRenderer >> initializeForBuffer: aBufferSurface [
	"Initalize sparta canvas to be used with a pixel buffer surface"
	| scaleFactor |

	windowExtent := aBufferSurface windowExtent.
	canvasExtent := aBufferSurface canvasExtent.

	scaleFactor := aBufferSurface scaleFactor.
	spartaCanvas := self class defaultCanvasBuilder forBufferOn: aBufferSurface.
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Failed to create sparta canvas' ].

	spartaCanvas transform
		scaleBy: scaleFactor;
		push
]

{ #category : #initialization }
BlSpartaRenderer >> initializeForForm: aFormSurface [
	"Initalize sparta canvas to be used with a form surface"
	| scaleFactor |

	windowExtent := aFormSurface windowExtent.
	canvasExtent := aFormSurface canvasExtent.

	scaleFactor := aFormSurface scaleFactor.
	spartaCanvas := self class defaultCanvasBuilder forFormOn: aFormSurface.
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Failed to create sparta canvas' ].

	spartaCanvas transform
		scaleBy: scaleFactor;
		push
]

{ #category : #initialization }
BlSpartaRenderer >> initializeForOpenGL: anOpenGLSurface [
	"Asks renderer to initialize itself to be used together with an OpenGL surface"
	| scaleFactor |

	ContextStackSignal emit.

	windowExtent := anOpenGLSurface windowExtent.
	canvasExtent := anOpenGLSurface canvasExtent.

	scaleFactor := anOpenGLSurface scaleFactor.
	spartaCanvas := self class defaultCanvasBuilder forOpenGLOn: anOpenGLSurface.
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Failed to create sparta canvas' ].

	spartaCanvas transform
		scaleBy: scaleFactor;
		push
]

{ #category : #initialization }
BlSpartaRenderer >> initializeHostSpace: aBlHostSpace [
	| availableSurfaces |
	
	availableSurfaces := (BlHostRendererSurface allSurfaces select: [ :aSurfaceClass | 
		(aSurfaceClass supportedBy: self class defaultCanvasBuilder class)
			and: [ aSurfaceClass supportedBy: aBlHostSpace ] ])
				sort: [ :a :b | a priority < b priority ].
		
	availableSurfaces ifEmpty: [ 
		^ self error: aBlHostSpace asString, ' does not support any available surfaces' ].
	
	surface := availableSurfaces first new.
	surface initializeOn: aBlHostSpace
]

{ #category : #'renderer - rendering' }
BlSpartaRenderer >> prepareToRender: aSpace [
	"I check if window extent changed since last rendering step and if yes, recreate resources"

	(session == Smalltalk session and: [ self hasResized not ])
		ifTrue: [ ^ self ].

	session := Smalltalk session.
	self surface initializeResourcesOn: self
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
