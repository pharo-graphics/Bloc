accessing
meta
	| meta |

	meta := BlAlternativeCombination new
		key: KeyboardKey leftMeta;
		key: KeyboardKey rightMeta;
		yourself.

	combination
		with: meta