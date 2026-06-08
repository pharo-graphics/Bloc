Extension { #name : #TextClassLink }

{ #category : #'*Bloc-Text' }
TextClassLink >> applyToBlText: aBlText [
	"Apply the receiver to the supplied BlText"
	
	aBlText attribute: (BlTextClassLink className: className)
]
