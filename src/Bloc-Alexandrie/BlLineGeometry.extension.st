Extension { #name : #BlLineGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlLineGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext | 
		cairoContext lineFrom: from to: to ]
]

{ #category : #'*Bloc-Alexandrie' }
BlLineGeometry >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [

	aeCanvas borderPathFactory: [ :cairoContext | 
		cairoContext lineFrom: from to: to ]
]

{ #category : #'*Bloc-Alexandrie' }
BlLineGeometry >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth [
"outskirts doesn't make sense for open geometry like line. Center border are handled by default.
We can force drawing the geometry, using the same logic for inside or outside border.  "

	self aeApplyWithInsideBorderTo: aeCanvas element: aBlElement borderWidth: aWidth
]
