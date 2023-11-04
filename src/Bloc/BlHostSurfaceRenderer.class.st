Class {
	#name : 'BlHostSurfaceRenderer',
	#superclass : 'Object',
	#package : 'Bloc',
	#tag : 'Universe - Renderer'
}

{ #category : 'initialization' }
BlHostSurfaceRenderer >> initializeForSurface: aSurface [

	self subclassResponsibility
]

{ #category : 'rendering' }
BlHostSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	"Render a given surface on a host space"

	self subclassResponsibility
]
