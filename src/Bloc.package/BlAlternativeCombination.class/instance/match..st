key matching
match: aKeyboardBuffer
	<return: #Number>
	
	^ self combinations
		inject: 0
		into: [ :max :aCombination | max max: (aCombination match: aKeyboardBuffer) ]