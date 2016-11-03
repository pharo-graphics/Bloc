testing
nameMatches: aClassName
	matchOnName
		ifFalse: [ ^ false ].
	^ name = aClassName