Class {
	#name : 'AeBorderedFigure',
	#superclass : 'AeFigure',
	#instVars : [
		'borderPathFactory',
		'borderBlock',
		'strokeWidth',
		'strokeSource'
	],
	#category : 'Bloc-AlexandrieCanvas2'
}

{ #category : 'accessing' }
AeBorderedFigure >> borderBlock: aFullBlockClosure [ 
	borderBlock := aFullBlockClosure
]

{ #category : 'API - border' }
AeBorderedFigure >> borderPathFactory: aFullBlockClosure [ 
	
	borderPathFactory:=aFullBlockClosure 
]

{ #category : 'private' }
AeBorderedFigure >> prepareStrokeWithDoubledWidth: cairoContext [ 
	
	borderBlock value: cairoContext.
	strokeSource applyOn: cairoContext.
	cairoContext lineWidth: strokeWidth * 2.0
]

{ #category : 'private' }
AeBorderedFigure >> prepareStrokeWithSingleWidth: cairoContext [ 

	borderBlock value: cairoContext.
	strokeSource applyOn: cairoContext.
	cairoContext lineWidth: strokeWidth
]

{ #category : 'accessing' }
AeBorderedFigure >> strokeSource: anObject [
	
	strokeSource:= anObject
]

{ #category : 'accessing' }
AeBorderedFigure >> strokeWidth: anInteger [ 
	
	strokeWidth:= anInteger 
]
