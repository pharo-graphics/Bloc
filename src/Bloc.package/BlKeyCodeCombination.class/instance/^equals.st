comparing
= aKeyCodeCombination
self class = aKeyCodeCombination class ifFalse: [ ^ false ].
	^ self charCode = aKeyCodeCombination charCode
		and: [ self modifiers = aKeyCodeCombination modifiers ]