printing
printOn: aStream
	spans do: [ :each | each printOn: aStream ]