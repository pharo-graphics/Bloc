Extension { #name : #BlSimpleShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlSimpleShadowEffect >> aeDrawBefore: aBlElement on: aeCanvas [ 
	
	aeCanvas setBackgroundWith: [ aeCanvas setSourceColor: color ].
	aeCanvas setBorderOff.

	self flag: #todo.
	"Visiting and applying the geometry path could be avoided afterwards"
	aBlElement geometry aeApplyTo: aeCanvas element: aBlElement.

	aeCanvas shouldClipAfterDrawingFigure: false.

	aeCanvas restoreContextAfter: [
		aeCanvas pathTranslate: offset.
		aeCanvas drawFigure ]
]
