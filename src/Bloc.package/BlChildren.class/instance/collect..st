children - enumerating
collect: aBlock 
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	Collect the resulting values into a collection like the receiver. Answer  
	the new collection."
	<return: #Array>

	^ Array streamContents: [ :aStream |
		self do: [ :anElement | aStream nextPut: (aBlock value: anElement) ] ]