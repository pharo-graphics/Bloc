Extension { #name : #BlOutskirtsOutside }

{ #category : #'*Bloc-Alexandrie' }
BlOutskirtsOutside >> aeApplyTo: aeCanvas element: aBlElement border: aBlBorder [

	aBlBorder aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement
]
