Extension { #name : 'BlSimpleShadowEffect' }

{ #category : '*Bloc-Alexandrie' }
BlSimpleShadowEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	aeCanvas setSourceColor: color.
	aeCanvas maskGroupWith: [
		aeCanvas pathTranslate: offset.
		aBlElement aeDrawGeometryOn: aeCanvas ]
]
