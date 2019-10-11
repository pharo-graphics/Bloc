"
I define the public API that host renderers must provide.
"
Trait {
	#name : #TBlHostRenderer,
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #'renderer - rendering' }
TBlHostRenderer >> doRender: aSpace dirtyAreas: aCollectionOfRectangles [
	self explicitRequirement
]

{ #category : #'renderer - rendering' }
TBlHostRenderer >> finishedRender: aSpace [
	"Perform neccessary actions after rendering is complete.
	By default I clear dirty areas of a given space"

	aSpace clearDirtyAreas
]

{ #category : #'renderer - testing' }
TBlHostRenderer >> hasResized [
	"Return true if host space resized since previous frame, otherwise false"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #initialization }
TBlHostRenderer >> initializeForBuffer: aBufferSurface [
	"Asks renderer to initialize itself to be used together with a pixel buffer surface"

	self explicitRequirement
]

{ #category : #initialization }
TBlHostRenderer >> initializeForForm: aFormSurface [
	"Asks renderer to initialize itself to be used together with a form surface"

	self explicitRequirement
]

{ #category : #initialization }
TBlHostRenderer >> initializeForOpenGL: anOpenGLSurface [
	"Asks renderer to initialize itself to be used together with an OpenGL surface"

	self explicitRequirement
]

{ #category : #initialization }
TBlHostRenderer >> initializeHostSpace: aBlHostSpace [
	self explicitRequirement
]

{ #category : #'renderer - rendering' }
TBlHostRenderer >> prepareToRender: aSpace [
	self explicitRequirement
]

{ #category : #'renderer - rendering' }
TBlHostRenderer >> presentAreas: aCollection [
	self surface presentAreas: aCollection
]

{ #category : #'renderer - rendering' }
TBlHostRenderer >> render: aSpace [
	"Render a given space according to its dirty areas.
	Note: if there are no dirty areas nothing will happen, including window or canvas update"
	
	(self renderNeeded: aSpace)
		ifFalse: [ ^ self ].

	self surface prepareToRender: aSpace.
	 [ self surface renderFor: aSpace ]
		ensure: [ self finishedRender: aSpace ]
]

{ #category : #'renderer - testing' }
TBlHostRenderer >> renderNeeded: aSpace [
	"Return true if I need to render a given space.
	By default I check if there are any dirty areas, if there are none - no need to render"
	<return: #Boolean>

	^ aSpace dirtyAreas notEmpty
]

{ #category : #'renderer - testing' }
TBlHostRenderer >> supportsBufferSurface [
	"Return true if this renderer can work with buffer surface, false otherwise"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'renderer - testing' }
TBlHostRenderer >> supportsFormSurface [
	"Return true if this renderer can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'renderer - testing' }
TBlHostRenderer >> supportsOpenGLSurface [
	"Return true if this renderer can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'renderer - accessing' }
TBlHostRenderer >> surface [
	^ self explicitRequirement
]

{ #category : #'renderer - accessing' }
TBlHostRenderer >> surface: aRendererSurface [
	self explicitRequirement
]
