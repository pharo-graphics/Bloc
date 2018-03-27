accessing
control
	| control |

	control := BlAlternativeCombination new
		key: KeyboardKey leftControl;
		key: KeyboardKey rightControl;
		yourself.

	combination
		with: control