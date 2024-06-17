Extension { #name : #BlSvgPath2 }

{ #category : #'*Bloc-Alexandrie-SVG' }
BlSvgPath2 >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		"cairoContext useFillRuleWinding. <-- default for SVG"
		commands do: [ :each | each aeApplyOn: cairoContext ] ]
]
