key matching
matches: aKeyboardBuffer
	<return: #Boolean>
	
	^ self combinations
		ifEmpty: [ false ]
		ifNotEmpty: [ :theCombinations |
			theCombinations allSatisfy: [ :aCombination | aCombination matches: aKeyboardBuffer ] ]