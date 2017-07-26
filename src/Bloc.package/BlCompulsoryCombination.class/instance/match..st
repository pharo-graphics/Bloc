key matching
match: aKeyboardBuffer
	<return: #Number>

	^ self combinations
		detectSum: [ :aCombination | aCombination match: aKeyboardBuffer ]