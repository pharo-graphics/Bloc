Extension { #name : #BlTextBorderAttribute }

{ #category : #'*Bloc-Alexandrie' }
BlTextBorderAttribute >> aeDrawAboveOn: aeCanvas span: aBASpan [

	isAbove ifFalse: [ ^ self ].
	self aeDrawOn: aeCanvas span: aBASpan
]

{ #category : #'*Bloc-Alexandrie' }
BlTextBorderAttribute >> aeDrawBelowOn: aeCanvas span: aBASpan [

	isAbove ifTrue: [ ^ self ].
	self aeDrawOn: aeCanvas span: aBASpan
]

{ #category : #'*Bloc-Alexandrie' }
BlTextBorderAttribute >> aeDrawOn: aeCanvas span: aBASpan [

	aeCanvas
		restoreContextAfterPaintAlpha: border opacity
		with: [
			aeCanvas pathFactory: [ :cairoContext |
				aBASpan appendPathOn: aeCanvas ].

			aeCanvas setBackgroundOff.
			aeCanvas setOutskirtsCentered.
			aeCanvas setBorderBlock: [
				border paint aeApplyTo: aeCanvas.

				aeCanvas
					setDashes: border style dashArray
					offset: border style dashOffset.

				border style lineJoin
					aeApplyTo: aeCanvas
					style: border style.

				border style lineCap aeApplyTo: aeCanvas.

				aeCanvas setBorderWidth: border width ].
			
			aeCanvas drawFigure ]
]
