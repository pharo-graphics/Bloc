Extension { #name : #BlTextBackgroundAttribute }

{ #category : #'*Bloc-Alexandrie' }
BlTextBackgroundAttribute >> aeDrawBelowOn: aeCanvas span: aBASpan [
	"Render a rectangle under text span"

	aeCanvas restoreContextAfter: [ 

		aeCanvas
			setBackgroundWith: [ aeCanvas setSourceColor: paint ]
				alpha: 1.0.

		aeCanvas setBorderOff.
		"ToDo: set line joins?"

		aeCanvas drawClosedPathWith: [ :cairoContext |
			| aRectangle |
			aRectangle := aBASpan bounds "translateBy: aBASpan baselinePoint".
			cairoContext rectangle: aRectangle ].

		aeCanvas drawFigure.
		
		]
]
