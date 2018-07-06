text - printing
printOn: aStream
	 [ self do: [ :aChar | aStream nextPut: aChar ] ]
		on: Error do: [ :e | aStream nextPutAll: e description ]