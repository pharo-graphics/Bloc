Extension { #name : #BlTextBackgroundAttribute }

{ #category : #'*Bloc-Alexandrie' }
BlTextBackgroundAttribute >> aeDrawBelowOn: aeCanvas span: aBASpan [
	"Render a rectangle under text span"

	aeCanvas restoreContextAfter: [ 

		aeCanvas pathFactory: [ :cairoContext |
			cairoContext rectangle: aBASpan bounds. ].

		aeCanvas setBackgroundWith: [
			aeCanvas setSourceColor: paint ].

		aeCanvas setBorderOff.
		"ToDo: set line joins?"

		aeCanvas drawFigure.
		
		]
]
