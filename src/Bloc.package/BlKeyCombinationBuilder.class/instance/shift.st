accessing
shift
	| shift |

	shift := BlAlternativeCombination new
		key: KeyboardKey leftShift;
		key: KeyboardKey rightShift;
		yourself.
		
	combination
		with: shift