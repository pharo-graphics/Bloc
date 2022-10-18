"
I am a mediator between host space and host renderer

"
Class {
	#name : #BlHostRendererSurface,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'physicalSize',
		'scaleFactor',
		'shouldUpdateEveryFrame',
		'updateActions'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererSurface class >> allSurfaces [
	"Return a collection of all possible surfaces"
	<return: #Collection of: #'BlHostRendererSurface class'>

	^ self allSubclasses
]

{ #category : #'instance creation' }
BlHostRendererSurface class >> newForHostSpace: aBlHostSpace [

	^ self new
		  initializeForHostSpace: aBlHostSpace;
		  yourself
]

{ #category : #testing }
BlHostRendererSurface class >> supportedBy: anObject [
	"Return true if a given object supports this surface, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'api - updates' }
BlHostRendererSurface >> addUpdateAction: aValuable [
	updateActions add: aValuable
]

{ #category : #initialization }
BlHostRendererSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> createSurfaceRendererOn: aBlHostSpace [

	^ self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: #extent may be different from canvas or window extents"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> initialize [
	super initialize.
	
	shouldUpdateEveryFrame := false.
	updateActions := OrderedCollection new
]

{ #category : #initialization }
BlHostRendererSurface >> initializeForHostSpace: aBlHostSpace [
	physicalSize := aBlHostSpace physicalSize.
	scaleFactor := aBlHostSpace scaleFactor
]

{ #category : #geometry }
BlHostRendererSurface >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."

	^ self physicalSize asLogical: self scaleFactor
]

{ #category : #initialization }
BlHostRendererSurface >> newSpaceRendererOn: aBlHostSpace [

	^ (self createSpaceRendererOn: aBlHostSpace)
		initializeForSurface: self;
		yourself
]

{ #category : #initialization }
BlHostRendererSurface >> newSurfaceRendererOn: aBlHostSpace [

	^ (self createSurfaceRendererOn: aBlHostSpace)
		initializeForSurface: self;
		yourself
]

{ #category : #'api - updates' }
BlHostRendererSurface >> performUpdates [
	updateActions do: [ :eachUpdateAction | eachUpdateAction value ]
]

{ #category : #geometry }
BlHostRendererSurface >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."

	^ physicalSize
]

{ #category : #geometry }
BlHostRendererSurface >> scaleFactor [
	"Return a scaling dpi factor from logical to physical coordinates.
	On high DPI displays (e.g. Retina), scaling factor is > 1"
	
	^ scaleFactor
]

{ #category : #'api - updates' }
BlHostRendererSurface >> shouldUpdateEveryFrame [
	<return: #Boolean>

	^ shouldUpdateEveryFrame
]

{ #category : #'api - updates' }
BlHostRendererSurface >> updateEveryFrame [
	shouldUpdateEveryFrame := true
]
