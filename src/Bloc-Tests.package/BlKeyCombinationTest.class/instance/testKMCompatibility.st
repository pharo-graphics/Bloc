tests
testKMCompatibility
	| km kb |
	km := $c alt control asBlKeyCombination.
	kb := BlKeyCodeCombination new
		alt;
		ctrl;
		key:
			(Key character: $c).
	self assert: km equals: kb.
	km := $c control asBlKeyCombination.
	kb := BlKeyCodeCombination new
		ctrl;
		key:
			(Key character: $c).
	self assert: km equals: kb.
	km := ($c alt control , $d alt control) asBlKeyCombination.
	kb := BlCombinationSequence new
		add:
			(BlKeyCodeCombination new
				alt;
				ctrl;
				key:
					(Key character: $c));
		add:
			(BlKeyCodeCombination new
				alt;
				ctrl;
				key:
					(Key character: $d)).
	self assert: km equals: kb.
	km := ($c alt control | $d alt control) asBlKeyCombination.
	kb := BlCombinationAlternative new
		add:
			(BlKeyCodeCombination new
				alt;
				ctrl;
				key:
					(Key character: $c));
		add:
			(BlKeyCodeCombination new
				alt;
				ctrl;
				key:
					(Key character: $d)).
	self assert: km equals: kb