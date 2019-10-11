Class {
	#name : #BlGlutinRenderer,
	#superclass : #BlHostSurfaceRenderer,
	#instVars : [
		'window'
	],
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #'private - gl' }
BlGlutinRenderer >> makeCurrent [
	self window isValid
		ifFalse: [ ^ self ].
	
	self window makeCurrent
]

{ #category : #'private - gl' }
BlGlutinRenderer >> swapBuffers [
	self window swapBuffers
]

{ #category : #accessing }
BlGlutinRenderer >> window [
	<return: #GlutinWindowedContext>

	^ window
]

{ #category : #accessing }
BlGlutinRenderer >> window: aGlutinWindowedContext [
	window := aGlutinWindowedContext
]
