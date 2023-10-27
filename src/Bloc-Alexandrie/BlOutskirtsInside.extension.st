Extension { #name : 'BlOutskirtsInside' }

{ #category : '*Bloc-Alexandrie' }
BlOutskirtsInside >> aeApplyTo: aeCanvas element: aBlElement border: aBlBorder [

	aBlBorder aeApplyWithInsideBorderTo: aeCanvas element: aBlElement
]
