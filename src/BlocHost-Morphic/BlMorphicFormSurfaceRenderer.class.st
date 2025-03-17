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

	| aCairoSurface anExternalForm |
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

	aBlock value: aCairoSurface.
	aCairoSurface flush.
	
	spaceHostMorph form: anExternalForm.
	
	
	aCairoSurface externallyFree
]

{ #category : #rendering }
BlMorphicFormSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	"Render a given surface on a host space"

	spaceHostMorph form: aSurface form
]

{ #category : #accessing }
BlMorphicFormSurfaceRenderer >> spaceHostMorph [

	^ spaceHostMorph
]

{ #category : #accessing }
BlMorphicFormSurfaceRenderer >> spaceHostMorph: aBlMorphicSpaceHostMorph [

	spaceHostMorph := aBlMorphicSpaceHostMorph
]
