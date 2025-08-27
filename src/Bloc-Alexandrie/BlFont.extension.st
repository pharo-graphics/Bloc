Extension { #name : #BlFont }

{ #category : #'*Bloc-Alexandrie' }
BlFont >> asAeFTFace [

	^ BAFontConverter uniqueInstance faceFor: self
]

{ #category : #'*Bloc-Alexandrie' }
BlFont >> asAeHbFont [

	^ BAFontConverter uniqueInstance hbFontFor: self
]
