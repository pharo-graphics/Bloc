"
I define the public API needed to be used by the Universe and the Spaces.
I define the public API that Host Spaces must provide.
This API is mostly used by  the Universe and the Host-Independent Spaces.
An Host Space is an  actual screen area provided by the underlying Host.
This area is typically an host-specific window.
"
Trait {
	#name : #TBlHostSpace,
	#instVars : [
		'renderer',
		'host',
		'space',
		'universe'
	],
	#traits : 'TBlSpaceProperties',
	#classTraits : 'TBlSpaceProperties classTrait',
	#category : #'Bloc-Universe'
}

{ #category : #'host space - accessing' }
TBlHostSpace >> canvasExtent [
	"Return a window canvas size in user coordinates.
	This size may differ from the window size on high dpi (retina) screens.
	In most cases canvas is x2 larger than window in pixel on retina screens."
	<return: #Point>

	^ self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> close [
	self explicitRequirement
]

{ #category : #'host space - cursor' }
TBlHostSpace >> cursor: aCursor [
	"Change current cursor image/view to the given one"

	self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> densityDpi [
	"Return the screen density expressed as dots-per-inch"
	<return: #Number>
	
	^ self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachHost [
	host := nil
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachSpace [
	space := nil
]

{ #category : #'host space - accessing' }
TBlHostSpace >> detachUniverse [
	universe := nil
]

{ #category : #'host space - events' }
TBlHostSpace >> enqueueEvent: aBlEvent [
	"I dispatch events directly to the universe or space as soon as they come"

	aBlEvent isUniverseEvent
		ifTrue: [ ^ self universe dispatchEvent: aBlEvent ].

	aBlEvent isSpaceEvent
		ifTrue: [ ^ self space dispatchEvent: aBlEvent ].
		
	self space dispatchEvent: aBlEvent
]

{ #category : #'host space - events' }
TBlHostSpace >> fetchedEventsDo: aBlock [
	"Flush event queue and evaluate a given block with every queued event as argument"
]

{ #category : #'host space - events' }
TBlHostSpace >> generateEvents [
	"Generate more complex state change events such as window scale event when resolution of the screen changes"
]

{ #category : #'host space - testing' }
TBlHostSpace >> hasResized [
	"Return true if renderer extent changed.
	It may happen if window moved between displays with different dpi,
	e.g. from normal display to retina"
	<return: #Boolean>

	^ self renderer hasResized
]

{ #category : #'host space - accessing' }
TBlHostSpace >> host [
	"Return a host that was used to create this host space"
	<return: #BlHost>

	^ host
]

{ #category : #'host space - accessing' }
TBlHostSpace >> host: aBlHost [
	"Assign a host that was used to create this host space"
	
	host := aBlHost
]

{ #category : #initialization }
TBlHostSpace >> initializeForBuffer: aBufferSurface [
	"Asks host space to initialize itself to be used together with a pixel buffer surface.
	Default implementation simply connects renderer, host space and surface together"

	aBufferSurface hostSpace: self.
	aBufferSurface hostRenderer: self renderer.

	self renderer surface: aBufferSurface
]

{ #category : #initialization }
TBlHostSpace >> initializeForForm: anFormSurface [
	"Asks host space to initialize itself to be used together with a Form surface.
	Default implementation simply connects renderer, host space and surface together"

	anFormSurface hostSpace: self.
	anFormSurface hostRenderer: self renderer.

	self renderer surface: anFormSurface
]

{ #category : #initialization }
TBlHostSpace >> initializeForOpenGL: anOpenGLSurface [
	"Asks host space to initialize itself to be used together with an OpenGL surface.
	Default implementation simply connects renderer, host space and surface together"

	anOpenGLSurface hostSpace: self.
	anOpenGLSurface hostRenderer: self renderer.

	self renderer surface: anOpenGLSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> isVisible [
	"Return true if underlying window is shown, false otherwise.
	Note: If window was shown and then minimized it is still considered to be visible.
	Window can become invisible by asking it to hide"
	<return: #Boolean>

	^ self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> maximize [

	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> maximized [
	^ self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> minimize [

	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> minimized [
	^ self explicitRequirement
]

{ #category : #'host space - testing' }
TBlHostSpace >> needsRebuild [
	"Return true if window should be recreated after user saved and quit pharo"
	<return: #Boolean>
	
	^ self explicitRequirement
]

{ #category : #'host space - rendering' }
TBlHostSpace >> prepareToRender: aBlSpace onBufferSurface: aBlHostRendererBufferSurface [
	"Prepare host space to a given space on a buffer surface.
	By default dispatch directly to the renderer"

	self renderer prepareToRender: aBlSpace
]

{ #category : #'host space - rendering' }
TBlHostSpace >> prepareToRender: aBlSpace onFormSurface: aBlHostRendererFormSurface [
	"Prepare host space to a given space on a Form surface.
	By default dispatch directly to the renderer"

	self renderer prepareToRender: aBlSpace
]

{ #category : #'host space - rendering' }
TBlHostSpace >> prepareToRender: aBlSpace onOpenGLSurface: aBlHostRendererOpenGLSurface [
	"Prepare host space to a given space on an OpenGL surface.
	By default dispatch directly to the renderer"

	self renderer prepareToRender: aBlSpace
]

{ #category : #'host space - rendering' }
TBlHostSpace >> presentBufferSurface: aBlHostRendererBufferSurface areas: aCollectionOfAreas [
	self explicitRequirement
]

{ #category : #'host space - rendering' }
TBlHostSpace >> presentFormSurface: aBlHostRendererFormSurface areas: aCollectionOfAreas [
	self explicitRequirement
]

{ #category : #'host space - rendering' }
TBlHostSpace >> presentOpenGLSurface: aBlHostRendererOpenGLSurface areas: aCollectionOfAreas [
	self explicitRequirement
]

{ #category : #'host space - rendering' }
TBlHostSpace >> render: aSpace [
	"Render a given abstract space on an underlying window or visual area"

	self renderer render: aSpace
]

{ #category : #'host space - rendering' }
TBlHostSpace >> render: aBlSpace onBufferSurface: aBlHostRendererBufferSurface [
	"Render a given space on an a buffer surface.
	By default dispatch directly to the renderer"

	self renderer doRender: aBlSpace dirtyAreas: aBlSpace dirtyAreas
]

{ #category : #'host space - rendering' }
TBlHostSpace >> render: aBlSpace onFormSurface: aBlHostRendererFormSurface [
	"Render a given space on an a Form surface.
	By default dispatch directly to the renderer"

	self renderer doRender: aBlSpace dirtyAreas: aBlSpace dirtyAreas
]

{ #category : #'host space - rendering' }
TBlHostSpace >> render: aBlSpace onOpenGLSurface: aBlHostRendererOpenGLSurface [
	"Render a given space on an OpenGL surface.
	By default dispatch directly to the renderer"

	self renderer doRender: aBlSpace dirtyAreas: aBlSpace dirtyAreas
]

{ #category : #'host space - accessing' }
TBlHostSpace >> renderer [
	"Return host renderer used to render spaces"
	<return: #TBlHostRenderer>

	^ renderer
]

{ #category : #'host space - rendering' }
TBlHostSpace >> requestRedraw [
	"Space needs to redraw the window"
]

{ #category : #'host space - accessing' }
TBlHostSpace >> scaleFactor [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	^ (self canvasExtent / self windowExtent) asFloatPoint
]

{ #category : #'host space - displaying' }
TBlHostSpace >> show [
	self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> space [
	"Return a space I am assigned to"
	<return: #BlSpace>

	^ space
]

{ #category : #'host space - accessing' }
TBlHostSpace >> space: aSpace [
	"Assign me to a given space"

	space := aSpace
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsBufferSurface [
	"Return true if this host space can work with a buffer surface, false otherwise"
	<return: #Boolean>

	^ self host supportsBufferSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsFormSurface [
	"Return true if this host space can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsFormSurface
]

{ #category : #'host space - testing' }
TBlHostSpace >> supportsOpenGLSurface [
	"Return true if this host space can work with OpenGL surface, false otherwise"
	<return: #Boolean>
	
	^ self host supportsOpenGLSurface
]

{ #category : #'host space - displaying' }
TBlHostSpace >> toBack [
	self explicitRequirement
]

{ #category : #'host space - displaying' }
TBlHostSpace >> toFront [
	self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> universe [
	<return: #BlParallelUniverse>

	^ universe
]

{ #category : #'host space - accessing' }
TBlHostSpace >> universe: aUniverse [
	universe := aUniverse
]

{ #category : #'host space - accessing' }
TBlHostSpace >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>

	^ self explicitRequirement
]

{ #category : #'host space - accessing' }
TBlHostSpace >> windowExtent: anExtent [
	self explicitRequirement
]
