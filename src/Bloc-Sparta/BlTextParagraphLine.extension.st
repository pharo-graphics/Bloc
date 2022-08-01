Extension { #name : #BlTextParagraphLine }

{ #category : #'*Bloc-Sparta' }
BlTextParagraphLine >> drawOnSpartaCanvas: aCanvas [
	spans ifNil: [ ^self ].
	self spans do: [ :aSpan | aSpan drawOnSpartaCanvas: aCanvas ]
]
