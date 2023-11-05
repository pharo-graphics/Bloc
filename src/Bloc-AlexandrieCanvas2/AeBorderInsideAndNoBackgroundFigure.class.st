Class {
	#name : 'AeBorderInsideAndNoBackgroundFigure',
	#superclass : 'AeBorderedFigure',
	#category : 'Bloc-AlexandrieCanvas2'
}

{ #category : 'drawing' }
AeBorderInsideAndNoBackgroundFigure >> drawOn: cairoContext [

	path value: cairoContext.

	self restoreIfShouldntClip: cairoContext after: [

		"Paint border"
		self prepareStrokeWithDoubledWidth: cairoContext.
		cairoContext 
			clipPreserve;
			stroke ]
]
