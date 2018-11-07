Extension { #name : #Object }

{ #category : #'*Bloc' }
Object >> asElement [
	"By default object is visually represented as a printed string.
	Override me to customise the behaviour"

	^ BlTextElement text: self printString asRopedText
]
