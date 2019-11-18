Class {
	#name : #BlGlutinOpenGLSurfaceRenderer,
	#superclass : #BlGlutinSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlGlutinOpenGLSurfaceRenderer >> initializeForSurface: aSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	aSurface
		sampleCount: 8;
		stencilBits: 8;
		framebufferId: window gl framebufferId;
		framebufferFormat: (GlutinGLConstants bindingOf: #GL_RGBA8) value;
		extent: aSurface physicalSize asPoint
]

{ #category : #'host space - drawing' }
BlGlutinOpenGLSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	self swapBuffers
]
