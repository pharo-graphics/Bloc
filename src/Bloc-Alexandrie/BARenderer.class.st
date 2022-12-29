"
I am a host-renderer to draw a space's elements on an `AeCanvas`.

Both buffer and form host-spaces are supported.
"
Class {
	#name : #BARenderer,
	#superclass : #BlHostRenderer,
	#category : #'Bloc-Alexandrie-Renderer'
}

{ #category : #initialization }
BARenderer >> createBufferSpaceRenderer [

	^ BABufferSpaceRenderer new
]

{ #category : #initialization }
BARenderer >> createFormSpaceRenderer [

	^ BAFormSpaceRenderer new
]

{ #category : #initialization }
BARenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Please note, that it I be called multiple times"

	session := Smalltalk session.
	
	"we should mark it as a current one before initializing a canvas as it may rely on opengl context"
	aBlHostSpace makeCurrent.

	surface := aBlHostSpace newBlHostRendererSurface.
	surfaceRenderer := surface newSurfaceRendererOn: aBlHostSpace.
	spaceRenderer := surface newSpaceRendererOn: self.

	textMeasurer := BASpaceTextMeasurer new
		spaceRenderer: spaceRenderer;
		yourself

]
