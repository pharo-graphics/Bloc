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

{ #category : #accessing }
BlSpartaRenderer class >> pickCanvasForSurface: aSurface [
	<return: #BlSpartaCanvasBuilder>
	| theCanvases theSupportedCanvases |
	
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
	^ BlSpartaOpenGLSpaceRenderer new
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
BlSpartaRenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Please note, that it I be called multiple times"
	
	"create a new surface of a specific type for a given host space"
	surface := (self class pickSurfaceClassFor: aBlHostSpace) new.

	"creates surfaceRenderer and allocate / initialize a surface"
	surfaceRenderer := surface createSurfaceRendererOn: aBlHostSpace.
	surfaceRenderer initializeForSurface: surface.

	"creates spaceRenderer from the allocated surface"
	spaceRenderer := surface createSpaceRendererOn: self.
	spaceRenderer initializeForSurface: surface
]

{ #category : #'renderer - rendering' }
BlSpartaRenderer >> prepareToRender: aSpace [
	"I check if window extent changed since last rendering step and if yes, recreate resources"
]

{ #category : #'renderer - accessing' }
BlSpartaRenderer >> surface [
	^ surface
]

{ #category : #'renderer - accessing' }
BlSpartaRenderer >> surface: aRendererSurface [
	surface := aRendererSurface
]
