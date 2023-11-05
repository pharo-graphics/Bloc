Extension { #name : 'AeCairoSurface' }

{ #category : '*Bloc-AlexandrieCanvas2' }
AeCairoSurface >> paintOn: cairoContext [ 
	
	"TODO: wrap, as opacity may be <1"
	cairoContext
		sourceSurface: self x: 0.0 y: 0.0;
		paint
]
