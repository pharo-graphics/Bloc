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
