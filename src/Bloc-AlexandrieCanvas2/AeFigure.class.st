Class {
	#name : 'AeFigure',
	#superclass : 'Object',
	#instVars : [
		'background',
		'path',
		'shouldClipAfterDrawingFigure'
	],
	#category : 'Bloc-AlexandrieCanvas2'
}

{ #category : 'accessing' }
AeFigure >> background: anObject [ 
	background := anObject
]

{ #category : 'drawing' }
AeFigure >> drawOn: cairoContext [

	self subclassResponsibility
]

{ #category : 'API - background' }
AeFigure >> pathFactory: aFullBlockClosure [ 
	
	path := aFullBlockClosure 
]

{ #category : 'as yet unclassified' }
AeFigure >> restoreIfShouldntClip: cairoContext after: aBlock [

	shouldClipAfterDrawingFigure
		ifTrue: aBlock
		ifFalse: [ cairoContext restoreStateAfter: aBlock ]
]

{ #category : 'as yet unclassified' }
AeFigure >> shouldClipAfterDrawingFigure: aBoolean [

	shouldClipAfterDrawingFigure := aBoolean
]
