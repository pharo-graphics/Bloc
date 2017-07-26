key matching
matches: aKeyboardBuffer
	<return: #Boolean>

	^ self combinations
		anySatisfy: [ :aCombination | aCombination matches: aKeyboardBuffer ]