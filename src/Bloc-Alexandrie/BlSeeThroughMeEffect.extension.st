Extension { #name : #BlSeeThroughMeEffect }

{ #category : #'*Bloc-Alexandrie' }
BlSeeThroughMeEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	self flag: #todo. "draft -- prototype"

	aBlElement childrenDo: [ :each |
		aeCanvas pathTranslate: each position.
		each geometry aeApplyTo: aeCanvas element: each.
		aeCanvas preparePath.
		aeCanvas pathTranslate: each position negated ].

	aeCanvas privateAeCairoContext useFillRuleEvenOdd.

]
