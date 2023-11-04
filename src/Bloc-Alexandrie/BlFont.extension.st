Extension { #name : #BlFont }

{ #category : #'*Bloc-Alexandrie' }
BlFont >> asAeFTFace [

	^ BAFontConverter uniqueInstance faceFor: self
]
