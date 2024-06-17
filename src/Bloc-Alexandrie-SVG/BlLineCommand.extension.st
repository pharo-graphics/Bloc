Extension { #name : #BlLineCommand }

{ #category : #'*Bloc-Alexandrie-SVG' }
BlLineCommand >> aeApplyOn: cairoContext [

	cairoContext lineTo: to
]
