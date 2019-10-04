Class {
	#name : #BlGlutinRendererOpenGL,
	#superclass : #BlGlutinRenderer,
	#category : #'BlocHost-Glutin'
}

{ #category : #initialization }
BlGlutinRendererOpenGL >> initializeForOpenGL: aBlHostRendererOpenGLSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].
	self makeCurrent.
	aBlHostRendererOpenGLSurface
		extent:
			aBlHostRendererOpenGLSurface physicalSize width
				@ aBlHostRendererOpenGLSurface physicalSize height
]

{ #category : #'host space - drawing' }
BlGlutinRendererOpenGL >> presentOpenGLSurface: aBlHostRendererOpenGLSurface areas: aCollectionOfAreas [
	self makeCurrent.
	self swapBuffers
]
