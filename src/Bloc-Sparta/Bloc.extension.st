Extension { #name : #Bloc }

{ #category : #'*Bloc-Sparta' }
Bloc class >> useCairoSpartaCanvas [

	self preferableSpartaCanvas: (self environment at: #BlSpartaCairoCanvasBuilder)
]

{ #category : #'*Bloc-Sparta' }
Bloc class >> useSkiaSpartaCanvas [

	self preferableSpartaCanvas: (self environment at: #BlSpartaSkiaCanvasBuilder)
]
