Extension { #name : #BlRectangleGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRectangleGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangleTo: aBlElement extent ]

]
