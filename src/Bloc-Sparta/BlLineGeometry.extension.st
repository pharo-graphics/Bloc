Extension { #name : #BlLineGeometry }

{ #category : #'*Bloc-Sparta' }
BlLineGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape line: self from to: self to
]
