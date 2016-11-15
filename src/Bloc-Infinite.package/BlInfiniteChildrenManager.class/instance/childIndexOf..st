children accessing
childIndexOf: child
	|index|
	
	index := controller childIndexOf: child.
	index <= 0
		ifTrue: [ ^ 0 ].
	
	(bucket get: index)
		ifTrue: [ Error signal: 'can not get index of a hidden child' ].
		
	^ index - (bucket countOnesBefore: index)