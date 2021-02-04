Extension { #name : #BlTextHighlightAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextHighlightAttribute >> applyOnTextParagraph: aTextParagraph from: aStartIndex to: aToIndex [
	aTextParagraph highlight: self from: aStartIndex to: aToIndex
]
