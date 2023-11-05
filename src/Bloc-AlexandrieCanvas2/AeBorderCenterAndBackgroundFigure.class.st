Class {
	#name : 'AeBorderCenterAndBackgroundFigure',
	#superclass : 'AeBorderedFigure',
	#category : 'Bloc-AlexandrieCanvas2'
}

{ #category : 'drawing' }
AeBorderCenterAndBackgroundFigure >> drawOn: cairoContext [

	path value: cairoContext.

	"Need to restore clipping area to draw the border afterwards"
	cairoContext restoreStateAfter: [

 		"Paint background"
		cairoContext clipPreserve.
		background paintOn: cairoContext ].

	"Paint border, and clip if required"
	self prepareStrokeWithSingleWidth: cairoContext.
	shouldClipAfterDrawingFigure
		ifTrue: [ cairoContext strokePreserve; clip ]
		ifFalse: [ cairoContext stroke ]
]
