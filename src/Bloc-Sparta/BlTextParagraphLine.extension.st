Extension { #name : #BlTextParagraphLine }

{ #category : #'*Bloc-Sparta' }
BlTextParagraphLine >> drawOnSpartaCanvas: aCanvas [
	self spans do: [ :aSpan | aSpan drawOnSpartaCanvas: aCanvas ]
]
