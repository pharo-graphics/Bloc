Extension { #name : 'AeCairoPattern' }

{ #category : '*Bloc-AlexandrieCanvas2' }
AeCairoPattern >> paintOn: cairoContext [ 
	
	"TODO: wrap, as opacity may be <1"
	cairoContext
		source: self;
		paint
]
