children accessing
childIndexOf: aChildElement
	"Return the index of the child in regular perspective.
	Return 0 if child is not present in infinite element"
	<return: #Number>

	|index|
	
	index := controller childIndexOf: aChildElement.
	index <= 0
		ifTrue: [ ^ 0 ].

	(bucket get: index)
		ifTrue: [ Error signal: 'can not get index of a hidden child' ].
		
	^ index - (bucket countOnesBefore: index)