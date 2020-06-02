"
I am a concrete implementation of a BlHostRenderer.

I allow space to be rendered on sparta canvas without making any asumptions about concrete host space type
"
Class {
	#name : #BlSpartaRenderer,
	#superclass : #BlHostRenderer,
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
			BlHostRendererSurface allSurfaces anySatisfy: [ :aSurfaceClass |
				(aSurfaceClass supportedBy: aBuilderClass) and: [ aSurfaceClass supportedBy: BlUniverse default host ] ] ])
		sort: [ :a :b | a priority < b priority ]
]

{ #category : #accessing }
BlSpartaRenderer class >> defaultCanvasBuilder [
	<return: #BlSpartaCanvasBuilder>

	^ defaultCanvasBuilder ifNil: [ self pickCanvasBuilderClass new ]
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

{ #category : #accessing }
BlSpartaRenderer class >> pickCanvasForSurface: aSurface [
	<return: #BlSpartaCanvasBuilder>
	| theCanvases theSupportedCanvases |
	
	defaultCanvasBuilder ifNotNil: [ :aCanvasBuilder |
		(aSurface class supportedBy: aCanvasBuilder class)
			ifTrue: [ ^ defaultCanvasBuilder ] ].
	
	theCanvases := self availableCanvasBuilderClasses sorted: [ :a :b | a priority < b priority ].
	
	theSupportedCanvases := theCanvases
		select: [ :eachCanvas | aSurface class supportedBy: eachCanvas ].
	
	theSupportedCanvases
		ifEmpty: [ self error: '{1} is not supported by any canvas' ].

	^ theSupportedCanvases first new
]

{ #category : #accessing }
BlSpartaRenderer class >> pickSurfaceClassFor: aBlHostSpace [
	"Find a default sparta canvas builder among all available.
	Return a special null one if there are no available builders"
	<return: #'BlHostRendererSurface class'>
	| supportedSurfaces theCanvases theSupportedCanvases theBestCanvas |

	supportedSurfaces := BlHostRendererSurface allSurfaces select: [ :aSurfaceClass | aSurfaceClass supportedBy: aBlHostSpace ].
	
	theCanvases := self availableCanvasBuilderClasses sorted: [ :a :b | a priority < b priority ].

	theSupportedCanvases := theCanvases
		select: [ :eachCanvas | supportedSurfaces anySatisfy: [ :eachSurfaceClass | eachSurfaceClass supportedBy: eachCanvas ] ].

	theSupportedCanvases ifEmpty: [ 
		^ self error: (aBlHostSpace asString, ' does not support any canvas') ].
	
	theBestCanvas := theSupportedCanvases first.
	supportedSurfaces := (supportedSurfaces select: [ :aSurfaceClass | aSurfaceClass supportedBy: theBestCanvas ])
		sort: [ :a :b | a priority < b priority ].

	^ supportedSurfaces first
]

{ #category : #initialization }
BlSpartaRenderer >> createBufferSpaceRenderer [
	^ BlSpartaBufferSpaceRenderer new
]

{ #category : #initialization }
BlSpartaRenderer >> createFormSpaceRenderer [
	^ BlSpartaFormSpaceRenderer new
]

{ #category : #initialization }
BlSpartaRenderer >> createOpenGLSpaceRenderer [
	"^ BlSpartaOpenGLCompositingSpaceRenderer new"
	^ BlSpartaOpenGLSpaceRenderer new
]

{ #category : #initialization }
BlSpartaRenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Please note, that it I be called multiple times"
	
	session := Smalltalk session.
	
	"we should mark it as a current one before initializing a canvas as it may rely on opengl context"
	aBlHostSpace makeCurrent.
	
	"create a new surface of a specific type for a given host space"
	surface := (self class pickSurfaceClassFor: aBlHostSpace) new.
	surface initializeForHostSpace: aBlHostSpace.

	"creates surfaceRenderer and allocate / initialize a surface"
	surfaceRenderer := surface createSurfaceRendererOn: aBlHostSpace.
	surfaceRenderer initializeForSurface: surface.

	"creates spaceRenderer from the allocated surface"
	spaceRenderer := surface createSpaceRendererOn: self.
	spaceRenderer initializeForSurface: surface
]
