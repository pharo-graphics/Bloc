Extension { #name : #BlLine }

{ #category : #'*Bloc-Sparta' }
BlLine >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape line: self from to: self to
]
