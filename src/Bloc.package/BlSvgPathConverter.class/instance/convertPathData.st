operations
convertPathData

	path := OrderedCollection new.
	
	[ self skipBlanks. stream atEnd ] whileFalse: [
		| cmd |
		cmd := stream next.
		self assertValidCommand: cmd.
		self perform: cmd asString asSymbol.
	].

	^ path
	