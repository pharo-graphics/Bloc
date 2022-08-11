Class {
	#name : #BAMorphicWindowHost,
	#superclass : #BlMorphicWindowHost,
	#category : #'Bloc-Alexandrie-Renderer'
}

{ #category : #'driver selection' }
BAMorphicWindowHost class >> label [

	^ 'Morphic Alexandrie'
]

{ #category : #'host - api' }
BAMorphicWindowHost >> containsPoint: aPoint element: aBlElement geometry: aBlGeometry [

	^ aBlGeometry aeContainsPoint: aPoint in: aBlElement
]

{ #category : #'host - api' }
BAMorphicWindowHost >> createHostSpaceFor: aSpace [
	"Create and assign a new morphic host space for given bloc space"

	| aWindow aHostSpace|
	aWindow := self createMorphicWindowFor: aSpace.

	aHostSpace := BlMorphicWindowHostSpace new
		morphicWindow: aWindow;
		host: self;
		universe: self universe;
		space: aSpace;
		renderer: BARenderer new;
		yourself.

	aSpace hostSpace: aHostSpace
]

{ #category : #'host - api' }
BAMorphicWindowHost >> offscreenMeasureTextParagraph: aBlTextParagraph [

	AeOffscreen instance measureTextParagraph: aBlTextParagraph
]

{ #category : #'host - api' }
BAMorphicWindowHost >> visualBoundsOf: aBlElement [

	^ aBlElement geometryBounds
]
