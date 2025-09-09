Extension { #name : #BlFont }

{ #category : #'*Bloc-Alexandrie' }
BlFont >> asAeCairoFontFace [

	^ BAFontConverter uniqueInstance faceFor: self
]

{ #category : #'*Bloc-Alexandrie' }
BlFont >> asAeFTFace [

	self deprecated: 'Migrate our code to #asAeCairoFontFace'.

	^ self error
]
