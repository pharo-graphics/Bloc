Class {
	#name : #BlGlutinOpenGLSurfaceRenderer,
	#superclass : #BlGlutinSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlGlutinOpenGLSurfaceRenderer >> initializeForSurface: aSurface [
	| aPixelFormat |
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	aPixelFormat := window pixelFormat.

	aSurface
		sampleCount: aPixelFormat multisapling;
		stencilBits: aPixelFormat stencilBits;
		framebufferId: window gl framebufferId;
		framebufferFormat: (GlutinGLConstants bindingOf: #GL_RGBA8) value;
		extent: aSurface physicalSize asPoint
]

{ #category : #'host space - drawing' }
BlGlutinOpenGLSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	self swapBuffers
]
