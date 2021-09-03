Class {
	#name : 'BlGlutinSurfaceRenderer',
	#superclass : 'BlHostSurfaceRenderer',
	#instVars : [
		'window'
	],
	#category : 'BlocHost-Glutin-Renderer'
}

{ #category : 'private - gl' }
BlGlutinSurfaceRenderer >> makeCurrent [
	self window isValid
		ifFalse: [ ^ self ].
	
	self window makeCurrent
]

{ #category : 'private - gl' }
BlGlutinSurfaceRenderer >> swapBuffers [
	self window swapBuffers
]

{ #category : 'accessing' }
BlGlutinSurfaceRenderer >> window [
	<return: #GlutinWindowedContext>

	^ window
]

{ #category : 'accessing' }
BlGlutinSurfaceRenderer >> window: aGlutinWindowedContext [
	window := aGlutinWindowedContext
]
