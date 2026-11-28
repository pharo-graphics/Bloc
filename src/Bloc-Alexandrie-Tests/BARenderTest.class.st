Class {
	#name : #BARenderTest,
	#superclass : #BAImageMatchTest,
	#category : #'Bloc-Alexandrie-Tests'
}

{ #category : #accessing }
BARenderTest >> actual [

	^ self surfaceForSpace: [ :aSpace | aSpace root aeAsCairoSurface ]
]

{ #category : #hooks }
BARenderTest >> expectedImagesSubdirectory [

	^ 'render'
]

{ #category : #hooks }
BARenderTest >> settings [

	"Allow 1.5% ratio for vertical 1-pixel text baseline shifts across platform font metrics."
	imageSelector = #buildTextAttributes ifTrue: [
		^ AeImageMatchSettings colorTolerance: 0.01 maxMismatchCount: 0 maxMismatchRatio: 0.015 ].

	"Allow a mismatch of 46 pixels that was observed ibetween CI Windows and local Macbook"
	imageSelector = #buildVariantsOfRectangle ifTrue: [
		^ AeImageMatchSettings colorTolerance: 0.01 maxMismatchCount: 46 maxMismatchRatio: 0.002 ].

	^ super settings
]
