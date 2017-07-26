accessing
shift
	| shift |

	shift := BlAlternativeCombination new
		key: Key leftShift;
		key: Key rightShift;
		yourself.
		
	combination
		with: shift