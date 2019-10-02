"
I am a mediator between host space and host renderer
"
Class {
	#name : #BlHostRendererSurface,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'hostSpace',
		'hostRenderer'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #accessing }
BlHostRendererSurface class >> allSurfaces [
	"Return a collection of all possible surfaces"
	<return: #Collection of: #'BlHostRendererSurface class'>

	^ self allSubclasses
]

{ #category : #testing }
BlHostRendererSurface class >> supportedBy: anObject [
	"Return true if a given object supports this surface, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> canvasExtent [
	"Return a window canvas size in user coordinates.
	This size may differ from the window size on high dpi (retina) screens.
	In most cases canvas is x2 larger than window in pixel on retina screens."
	<return: #Point>
	
	self
		deprecated: 'Please use #physicalSize instead'
		transformWith: '`@receiver canvasExtent' 
						-> '(`@receiver physicalSize width @ `@receiver physicalSize height)'.

	^ self physicalSize width @ self physicalSize height
]

{ #category : #geometry }
BlHostRendererSurface >> dpiFactor [
	"Return a scaling dpi factor from logical to physical coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Number>
	
	^ self hostSpace dpiFactor
]

{ #category : #geometry }
BlHostRendererSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: between frames #extent may be different from canvas or window extents because
	those two methods return immediate/current window extent by asking host window directly"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlHostRendererSurface >> hostRenderer [
	^ hostRenderer
]

{ #category : #accessing }
BlHostRendererSurface >> hostRenderer: anObject [
	hostRenderer := anObject
]

{ #category : #accessing }
BlHostRendererSurface >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlHostRendererSurface >> hostSpace: anObject [
	hostSpace := anObject
]

{ #category : #initialization }
BlHostRendererSurface >> initializeOn: anObject [
	"Initialize a given object to work with this surface.
	must be implemented by subclasses"
	
	self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> initializeResourcesOn: aHostRenderer [
	"Initialize me and host renderer depending on surface type.
	must be implemented by subclasses"
	
	self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."
	<return: #BlHostLogicalSize>

	^ self hostSpace logicalSize
]

{ #category : #geometry }
BlHostRendererSurface >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."
	<return: #BlHostPhysicalSize>

	^ self hostSpace physicalSize
]

{ #category : #rendering }
BlHostRendererSurface >> prepareToRender: aSpace [
	"Dispatch preparation to render through host space based on surface type"
	
	self subclassResponsibility
]

{ #category : #presenting }
BlHostRendererSurface >> presentAreas: aCollectionOfRectangles [
	self subclassResponsibility
]

{ #category : #rendering }
BlHostRendererSurface >> renderFor: aSpace [
	"Dispatch render process through host space based on surface type"
	
	self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> scaleFactor [
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	self
		deprecated: 'Please use #dpiFactor instead'
		transformWith: '`@receiver scaleFactor' 
						-> '`@receiver dpiFactor asPoint'.

	^ self dpiFactor asPoint
]

{ #category : #geometry }
BlHostRendererSurface >> windowExtent [
	"Return the window size in screen coordinates.
	This size may differ from the size in pixels of underlying surface 
	on high dpi (retina) screens"
	<return: #Point>

	self
		deprecated: 'Please use #logicalSize instead'
		transformWith: '`@receiver windowExtent' 
						-> '(`@receiver logicalSize width @ `@receiver logicalSize height)'.

	^ self logicalSize width @ self logicalSize height
]
