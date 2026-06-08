Extension { #name : #TextVariableLink }

{ #category : #'*Bloc-Text' }
TextVariableLink >> applyToBlText: aBlText [
	"Apply the receiver to the supplied BlText"
	
	aBlText attribute: (BlTextVariableLink variableName: variableName)
]
