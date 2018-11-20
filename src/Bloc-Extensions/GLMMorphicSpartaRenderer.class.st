"
I render Sparta presentation that should be able to be used within morphic
"
Class {
	#name : #GLMMorphicSpartaRenderer,
	#superclass : #GLMMorphicInstallablePresentationRenderer,
	#category : #'Bloc-Extensions-Renderers'
}

{ #category : #rendering }
GLMMorphicSpartaRenderer >> morphFrom: aSpartaPresentation [
	| canvas |
	
	canvas := aSpartaPresentation canvas extent: aSpartaPresentation extent.
	aSpartaPresentation drawBlock value: canvas.
	
	^ canvas asForm asMorph
]
