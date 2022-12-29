Extension { #name : #Bloc }

{ #category : #'*Bloc-Sparta' }
Bloc class >> preferableSpartaCanvas [
	^ PreferableSpartaCanvasBuilder ifNil: [ PreferableSpartaCanvasBuilder := (self environment at: #BlSpartaRenderer) defaultCanvasBuilder class ]
]

{ #category : #'*Bloc-Sparta' }
Bloc class >> preferableSpartaCanvas: aBuilderClass [
	PreferableSpartaCanvasBuilder := aBuilderClass.
	
	"change preferable universe host according to new setting"
	(self environment at: #BlSpartaRenderer) defaultCanvasBuilder: aBuilderClass new
]

{ #category : #'*Bloc-Sparta' }
Bloc class >> useCairoSpartaCanvas [

	self preferableSpartaCanvas: (self environment at: #BlSpartaCairoCanvasBuilder)
]

{ #category : #'*Bloc-Sparta' }
Bloc class >> useSkiaSpartaCanvas [

	self preferableSpartaCanvas: (self environment at: #BlSpartaSkiaCanvasBuilder)
]
