Extension { #name : #BrTextParagraphLine }

{ #category : #'*Bloc-Sparta' }
BrTextParagraphLine >> drawOnSpartaCanvas: aCanvas [
	self spans do: [ :aSpan | aSpan drawOnSpartaCanvas: aCanvas ]
]
