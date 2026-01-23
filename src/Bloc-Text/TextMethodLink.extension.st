Extension { #name : #TextMethodLink }

{ #category : #'*Bloc-Text' }
TextMethodLink >> applyToBlText: aBlText [
	"Apply the receiver to the supplied BlText"
	
	aBlText attribute: (BlTextMethodLink selector: selector)
]
