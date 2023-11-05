Class {
	#name : 'AeBorderCenterAndNoBackgroundFigure',
	#superclass : 'AeBorderedFigure',
	#category : 'Bloc-AlexandrieCanvas2'
}

{ #category : 'drawing' }
AeBorderCenterAndNoBackgroundFigure >> drawOn: cairoContext [

	path applyOn: cairoContext.

	"Paint border, and clip if required"
	self prepareStrokeWithSingleWidth: cairoContext.
	shouldClipAfterDrawingFigure
		ifTrue: [ cairoContext strokePreserve; clip ]
		ifFalse: [ cairoContext stroke ]
]
