Class {
	#name : 'AeBackgroundAndNoBorderFigure',
	#superclass : 'AeFigure',
	#category : 'Bloc-AlexandrieCanvas2'
}

{ #category : 'drawing' }
AeBackgroundAndNoBorderFigure >> drawOn: cairoContext [

	path value: cairoContext.

	self restoreIfShouldntClip: cairoContext after: [

		"Paint background"
		cairoContext clip.
		background paintOn: cairoContext ]
]
