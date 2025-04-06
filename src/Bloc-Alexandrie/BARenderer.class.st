"
I am a host-renderer to draw a space's elements on an `AeCanvas`.

Both buffer and form host-spaces are supported.
"
Class {
	#name : #BARenderer,
	#superclass : #BlHostRenderer,
	#instVars : [
		'aeCanvas'
	],
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
BARenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Note: an instance can be initialized multiple times."

	self initialize.

	physicalSize := aBlHostSpace physicalSize.
	scaleFactor := aBlHostSpace scaleFactor.

	session := Smalltalk session.
	textMeasurer := BAOffscreen instance textMeasurer.
	aeCanvas := AeCanvas newWithoutSurface
]

{ #category : #rendering }
BARenderer >> render: aHostSpace [
	"Render a given space according to its dirty areas.
	Note: if there are no dirty areas nothing will happen, including window
	or canvas update."

	self isValid ifFalse: [ ^ self ].

	aHostSpace space hasDirtyElements ifFalse: [ ^ self ].

	[	aHostSpace
			lockSurfaceFor: aHostSpace space damagedRectangles
			scaleFactor: scaleFactor
			during: [ :aCanvas | aHostSpace space aeFullDrawOn: aCanvas ] ]

		ensure: [ aHostSpace space clearDirtyElements ]
]

{ #category : #rendering }
BARenderer >> renderWith: aBlock pixels: address stride: stride physicalRectangle: physicalRectangle logicalRectangle: logicalRectangle [

	| aCairoSurface |
	aCairoSurface := AeCairoImageSurface
		unownedNewForData: address
	   format: AeCairoSurfaceFormat argb32
	   width: physicalRectangle width
	   height: physicalRectangle height
	   stride: stride.
	aCairoSurface
		deviceOffset: physicalRectangle origin negated;
		deviceScaleX: scaleFactor y: scaleFactor.
		
	aeCanvas prepareForSurface: aCairoSurface.
	aeCanvas clippingRectangle: logicalRectangle.

	self flag: #todo. "Extract to settings"
	"On High DPI displays, high quality is not visible enough, and often 
	much larger surface areas are painted."
	scaleFactor > 1.0 ifTrue: [ aeCanvas setLowQualityOptions ].
		
	aBlock value: aeCanvas.

	aCairoSurface flush.
	aeCanvas removeSurface.
	aCairoSurface externallyFree
]
