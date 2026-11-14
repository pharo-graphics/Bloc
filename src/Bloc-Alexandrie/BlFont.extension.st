Extension { #name : #BlFont }

{ #category : #'*Bloc-Alexandrie' }
BlFont >> asAeFTFace [

	self deprecated: 'Migrate our code to #asAeCairoFontFace'.

	^ self error
]
