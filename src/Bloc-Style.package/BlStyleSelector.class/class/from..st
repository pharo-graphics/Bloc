as yet unclassified
from: anObject
	anObject isSymbol
		ifTrue: [ ^ self fromSymbol: anObject ].
	(anObject isArray and: [ anObject size = 1 ])
		ifTrue: [ ^ self fromSymbol: anObject first ].
	anObject isArray
		ifTrue: [ ^ self fromSymbols: anObject ]