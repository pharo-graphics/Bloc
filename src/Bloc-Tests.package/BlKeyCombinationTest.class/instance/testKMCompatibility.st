tests
testKMCompatibility
|km kb|
	km  := ($c alt control) asBlKeyCombination.
	kb := 	BlKeyCodeCombination new alt;ctrl;char:$c.
	
	self assert: km equals: kb.
	
	km  := ($c control) asBlKeyCombination.
	kb := 	BlKeyCodeCombination new ctrl;char:$c.
		
	self assert: km equals: kb.
	
	
	km  := ($c alt control, $d alt control) asBlKeyCombination.
	kb := 	BlCombinationSequence new
		add:(BlKeyCodeCombination new alt;ctrl;char:$c);
		add:(BlKeyCodeCombination new alt;ctrl;char:$d).
	
	self assert: km equals: kb.
	
	km  := ($c alt control | $d alt control) asBlKeyCombination.
	kb := 	BlCombinationAlternative new
		add:(BlKeyCodeCombination new alt;ctrl;char:$c);
		add:(BlKeyCodeCombination new alt;ctrl;char:$d).
		
	self assert: km equals: kb.
	