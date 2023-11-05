Class {
	#name : 'AeBorderInsideAndBackgroundFigure',
	#superclass : 'AeBorderedFigure',
	#category : 'Bloc-AlexandrieCanvas2'
}

{ #category : 'drawing' }
AeBorderInsideAndBackgroundFigure >> drawOn: cairoContext [

	path value: cairoContext.

	self restoreIfShouldntClip: cairoContext after: [

		"Paint background"
		cairoContext clipPreserve.
		background paintOn: cairoContext.

		"Paint border"
		self prepareStrokeWithDoubledWidth: cairoContext.
		cairoContext stroke ]

]
