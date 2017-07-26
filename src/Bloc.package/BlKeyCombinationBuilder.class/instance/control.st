accessing
control
	| control |

	control := BlAlternativeCombination new
		key: Key leftControl;
		key: Key rightControl;
		yourself.

	combination
		with: control