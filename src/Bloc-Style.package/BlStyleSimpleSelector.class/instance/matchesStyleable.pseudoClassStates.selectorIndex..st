testing
matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex
	(self matchesStyleable: aStyleable)
		ifFalse: [ ^ false ].
	aPseudoClassStateList
		ifNotEmpty:
			[ :c | (self matchesPseudoClasseState: (c last))
				ifFalse: [ ^ false ] ].
	^ true