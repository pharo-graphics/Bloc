comparing
= aKeyCodeCombination
self class = aKeyCodeCombination class ifFalse: [ ^ false ].
	^ self key = aKeyCodeCombination key
		and: [ self modifiers = aKeyCodeCombination modifiers ]