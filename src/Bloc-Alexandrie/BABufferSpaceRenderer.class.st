Class {
	#name : 'BABufferSpaceRenderer',
	#superclass : 'BASpaceRenderer',
	#category : 'Bloc-Alexandrie-Renderer'
}

{ #category : 'initialization' }
BABufferSpaceRenderer >> initializeForSurface: aBlHostRendererBufferSurface [ 

	self
		initializeForSurface: aBlHostRendererBufferSurface
		and: (AeCairoImageSurface
					newForData: aBlHostRendererBufferSurface buffer
					extent: aBlHostRendererBufferSurface extent
					stride: aBlHostRendererBufferSurface stride
					format: AeCairoSurfaceFormat argb32)

]
