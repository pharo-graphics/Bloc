Extension { #name : #SpartaCanvas }

{ #category : #'*Bloc-Sparta' }
SpartaCanvas >> drawTextParagraph: aTextParagraph [
	aTextParagraph drawOnSpartaCanvas: self
]

{ #category : #'*Bloc-Sparta' }
SpartaCanvas >> fullDraw: anObject [
	^ anObject fullDrawOnSpartaCanvas: self
]
