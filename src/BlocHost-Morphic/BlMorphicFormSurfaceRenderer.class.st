Class {
	#name : #BlMorphicFormSurfaceRenderer,
	#superclass : #BlHostSurfaceRenderer,
	#instVars : [
		'spaceHostMorph'
	],
	#category : #'BlocHost-Morphic-Common'
}

{ #category : #initialization }
BlMorphicFormSurfaceRenderer >> initializeForSurface: aSurface [

	| anExternalForm |
	anExternalForm := BlExternalForm
		extent: aSurface physicalSize asPoint
		depth: 32.
	anExternalForm autoRelease.
	anExternalForm allocateSpace.
	anExternalForm fillColor: Color transparent.
	
	aSurface form: anExternalForm
]

{ #category : #rendering }
BlMorphicFormSurfaceRenderer >> lockSurfaceFor: damagedRectangles scaleFactor: aNumber during: aBlock [

	| aCairoSurface anExternalForm aeCanvas |
	anExternalForm := BlExternalForm
		extent: spaceHostMorph extent
		depth: 32.
	anExternalForm autoRelease.
	anExternalForm allocateSpace.

	aCairoSurface := AeCairoImageSurface
				unownedNewForData: anExternalForm pointer
			   format: AeCairoSurfaceFormat argb32
			   width: spaceHostMorph width
			   height: spaceHostMorph height
			   stride: anExternalForm stride.

	aeCanvas := AeCanvas newFor: aCairoSurface.

	aBlock value: aeCanvas.
	aCairoSurface flush.
	aeCanvas privateAeCairoContext externallyFree.
	aCairoSurface externallyFree.

	spaceHostMorph form: anExternalForm
]

{ #category : #accessing }
BlMorphicFormSurfaceRenderer >> spaceHostMorph [

	^ spaceHostMorph
]

{ #category : #accessing }
BlMorphicFormSurfaceRenderer >> spaceHostMorph: aBlMorphicSpaceHostMorph [

	spaceHostMorph := aBlMorphicSpaceHostMorph
]
