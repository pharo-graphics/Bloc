Extension { #name : #BlTextDecorationAttribute }

{ #category : #'*Bloc-Alexandrie' }
BlTextDecorationAttribute >> aeDrawAboveOn: aeCanvas span: aBASpan [

	aeCanvas restoreContextAfter: [ 
		| fromX fromY toX toY |
		fromX := 0.0.
		toX := aBASpan advance.
		
		decoration typesDo: [ :eachType |
			eachType = BlTextDecorationType underline ifTrue: [
				fromY := 2. "magic number taken from Sparta... why 2?"
				toY := 2 + self thickness ].
			
			eachType = BlTextDecorationType lineThrough ifTrue: [				
				self notYetImplemented ].
			 ].
		
		aeCanvas
			setBackgroundWith: [ aeCanvas setSourceColor: self color ] 
				alpha: 1.0;
			setBorderOff.
		"ToDo: set line joins?"

		aeCanvas
			setPathKey: self
			hasJoins: true
			hasCaps: false
			block: [ :cairoContext |
				cairoContext
					primRectangleX: fromX
					y: fromY
					width: toX
					height: toY ].

		aeCanvas drawFigure.
		
		]
]
