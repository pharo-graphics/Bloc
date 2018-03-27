accessing
alt
	| alt |

	alt := BlAlternativeCombination new
		key: KeyboardKey leftAlt;
		key: KeyboardKey rightAlt;
		yourself.

	combination
		with: alt