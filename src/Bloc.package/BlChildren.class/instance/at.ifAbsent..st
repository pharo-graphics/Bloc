children - accessing
at: anIndex ifAbsent: exceptionBlock 
	"Answer the element at my position index. If I do not contain an element 
	at index, answer the result of evaluating the argument, exceptionBlock."

	(anIndex between: 1 and: self size)
		ifTrue: [ ^ self at: anIndex ].
	^ exceptionBlock value