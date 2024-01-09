Class {
	#name : #BASpaceRenderer,
	#superclass : #BlHostSpaceRenderer,
	#instVars : [
		'aeCanvas'
	],
	#category : 'Bloc-Alexandrie-Renderer'
}

{ #category : #accessing }
BASpaceRenderer >> aeCanvas [

	^ aeCanvas
]

{ #category : #initialization }
BASpaceRenderer >> initializeForSurface: aBlHostRendererSurface and: aeCairoSurface [

	aeCairoSurface deviceScale: aBlHostRendererSurface scaleFactor asPoint.
	aeCanvas := AeCanvas newFor: aeCairoSurface.

	"On High DPI displays, high quality is not visible enough, and often 
	much larger surface areas are painted."
	aBlHostRendererSurface scaleFactor > 1.0
		ifTrue: [ aeCanvas setLowQualityOptions ]

]

{ #category : #rendering }
BASpaceRenderer >> renderSpace: aBlSpace [
	"Render a space and return a collection of damaged rectangles"

	aBlSpace aeFullDrawOn: aeCanvas.
	^ #()
]
