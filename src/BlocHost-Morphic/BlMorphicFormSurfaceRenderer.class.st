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
