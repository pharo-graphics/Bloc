Class {
	#name : 'BAFormSpaceRenderer',
	#superclass : 'BASpaceRenderer',
	#package : 'Bloc',
	#tag : 'Alexandrie-Renderer',
	#package : 'Bloc-Alexandrie',
	#tag : 'Renderer'
}

{ #category : 'initialization' }
BAFormSpaceRenderer >> initializeForSurface: aBlHostRendererFormSurface [ 

	self
		initializeForSurface: aBlHostRendererFormSurface
		and: (AeCairoImageSurface
					newForData: aBlHostRendererFormSurface pointer
					extent: aBlHostRendererFormSurface extent
					stride: aBlHostRendererFormSurface stride
					format: AeCairoSurfaceFormat argb32)
]
