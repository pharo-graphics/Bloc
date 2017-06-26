printing
printOn: aStream
	aStream nextPut: $(.
	x printOn: aStream.
	aStream nextPut: $@.
	(y notNil and: [y negative])
		ifTrue: [
			"Avoid ambiguous @- construct"
			aStream space].
	y printOn: aStream.
	aStream nextPut: $@.
	(z notNil and: [z negative])
		ifTrue: [
			"Avoid ambiguous @- construct"
			aStream space].
	z printOn: aStream.
	aStream nextPut: $).