Extension { #name : #BlMoveCommand }

{ #category : #'*Bloc-Alexandrie-SVG' }
BlMoveCommand >> aeApplyOn: cairoContext [

	cairoContext moveTo: to
]
