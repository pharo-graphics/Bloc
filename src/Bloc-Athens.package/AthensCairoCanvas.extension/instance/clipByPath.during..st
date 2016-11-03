*Bloc-Athens
clipByPath: aPathOrNil during: aBlock
	aPathOrNil ifNotNil: [ self setClipPath: aPathOrNil ].
	aBlock value