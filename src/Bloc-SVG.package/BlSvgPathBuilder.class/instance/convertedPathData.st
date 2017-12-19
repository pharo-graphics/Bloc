operations
convertedPathData

	segments := OrderedCollection new.
	
	[ self skipBlanks. stream atEnd ]
		whileFalse: [ self performCommandNamed: stream next asString asSymbol ].

	^ segments