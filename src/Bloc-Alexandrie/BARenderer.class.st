"
I am a host-renderer to draw a space's elements on an `AeCanvas`.

Both buffer and form host-spaces are supported.
"
Class {
	#name : #BARenderer,
	#superclass : #BlHostRenderer,
	#category : #'Bloc-Alexandrie-Renderer'
}

{ #category : #accessing }
BARenderer class >> label [

	^ 'Alexandrie'
]

{ #category : #'host - api' }
BARenderer class >> newFormFrom: aBlElement [

	^ aBlElement aeAsForm
]

{ #category : #'host - api' }
BARenderer class >> offscreenMeasureTextParagraph: aBlTextParagraph [

	BAOffscreen instance measureTextParagraph: aBlTextParagraph
]

{ #category : #'host - api' }
BARenderer class >> write: aBlElement asPngTo: aFileReference [
	"Draw the element into a PNG at the specified location."

	BAExporter png
			target: aFileReference;
			element: aBlElement;
			export
]

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

	self initialize.

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

{ #category : #rendering }
BARenderer >> render: aHostSpace [
	"Render a given space according to its dirty areas.
	Note: if there are no dirty areas nothing will happen, including window
	or canvas update."

	| aSpace isRenderNeeded |
	self isValid ifFalse: [ ^ self ].

	aSpace := aHostSpace space.
	isRenderNeeded := aSpace hasDirtyElements.
	isRenderNeeded ifFalse: [ ^ self ].

	[	aHostSpace makeCurrent.

		surfaceRenderer
			lockSurfaceFor: aSpace damagedRectangles
			scaleFactor: surface scaleFactor
			during: [ :aeCanvas | aSpace aeFullDrawOn: aeCanvas ] ]

			ensure: [ aSpace clearDirtyElements ]
]
