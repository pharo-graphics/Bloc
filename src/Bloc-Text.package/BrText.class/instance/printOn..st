text - printing
printOn: aStream
	self do: [ :aChar | aStream nextPut: aChar ]