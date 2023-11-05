Extension { #name : 'BlImageBackground' }

{ #category : '*Bloc-AlexandrieCanvas2' }
BlImageBackground >> asBABackground [

	self haltIf: [ self opacity < 1.0 ].
	^ AeCairoImageSurface fromForm: self image
]
