printing
printOn: aStream

	self hasRoot
		ifTrue: [ self root printOn: aStream ]