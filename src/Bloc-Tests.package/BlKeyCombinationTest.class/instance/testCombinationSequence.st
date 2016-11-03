as yet unclassified
testCombinationSequence
	| kb kbr evt1 evt2 flag |
	flag := false.
	
	evt1 := BlKeyboardEvent new
		charCode: $c asInteger;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
	evt2 := BlKeyboardEvent new
		charCode: $d asInteger;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
		
	kb := 	BlCombinationSequence new
		add:($c alt control) asBlKeyCombination;
		add:($d alt control) asBlKeyCombination.
		
	kb action:[flag := true].
	
	kbr := BlKeyCombinationRegistry new.
	kbr add: kb.
	
	kbr processEvent: evt1.
	kbr processEvent: evt2.
	
	self assert: flag
	
	
	