"
I am a mediator between host space and host renderer

"
Class {
	#name : #BlHostRendererSurface,
	#superclass : #Object,
	#instVars : [
		'physicalSize',
		'scaleFactor',
		'shouldUpdateEveryFrame',
		'updateActions'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #testing }
BlHostRendererSurface class >> isSupportedBy: anObject [
	"Return whether a given object supports this surface."
	
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlHostRendererSurface class >> newForHostSpace: aBlHostSpace [

	^ self new
		  initializeForHostSpace: aBlHostSpace;
		  yourself
]

{ #category : #accessing }
BlHostRendererSurface class >> priority [
	
	^ self subclassResponsibility
]

{ #category : #'api - updates' }
BlHostRendererSurface >> addUpdateAction: aValuable [

	updateActions add: aValuable
]

{ #category : #initialization }
BlHostRendererSurface >> createSpaceRendererOn: anObject [
	"Return a new `BlHostSpaceRenderer` in dialog with the received argument."

	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> createSurfaceRendererOn: aBlHostSpace [
	"Return a new `BlHostSurfaceRenderer` in dialog with the received argument."

	^ self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> extent [
	"Return a `Point` that represents the logical extent of the underlying surface.
	Note: This extent can difer from canvas or window extents."

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
	This size may differ from the logical size on high DPI screens.
	In most cases, physical size doubles the logical size."

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

	^ shouldUpdateEveryFrame
]

{ #category : #'api - updates' }
BlHostRendererSurface >> updateEveryFrame [

	shouldUpdateEveryFrame := true
]
