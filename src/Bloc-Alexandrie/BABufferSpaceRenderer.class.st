Class {
	#name : 'BABufferSpaceRenderer',
	#superclass : 'BASpaceRenderer',
	#package : 'Bloc',
	#tag : 'Alexandrie-Renderer',
	#package : 'Bloc-Alexandrie',
	#tag : 'Renderer'
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
