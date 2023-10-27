Extension { #name : 'BlTextDecorationAttribute' }

{ #category : '*Bloc-Alexandrie' }
BlTextDecorationAttribute >> aeDrawAboveOn: aeCanvas span: aBASpan [

	| fromY |
	aeCanvas restoreContextAfter: [ 
		aeCanvas
			setBackgroundWith: [ aeCanvas setSourceColor: self color ];
			setBorderOff.

		aeCanvas pathFactory: [ :cairoContext |
		
			decoration typesDo: [ :eachType |
				eachType = BlTextDecorationType underline
					ifTrue: [ fromY := 2 ]
					ifFalse: [
						eachType = BlTextDecorationType lineThrough
							ifTrue: [ fromY := aBASpan ascent / 4.0 ]
							ifFalse: [ self notYetImplemented ] ].
				
				cairoContext
					rectangleX: 0.0
					y: fromY
					width: aBASpan advance
					height: fromY + self thickness ] ].

		aeCanvas drawFigure ]
]
