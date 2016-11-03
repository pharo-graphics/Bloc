as yet unclassified
testCombinationSequence2
	| kb kbr evt1 evt2 flag |
	flag := false.
	
	evt1 := BlKeyboardEvent new
		charCode: $c asInteger;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
	evt2 := BlKeyboardEvent new
		charCode: $d asInteger.
		
	kb := ($c alt control , $d) asBlKeyCombination.
		
	kb action:[flag := true].
	
	kbr := BlKeyCombinationRegistry new.
	kbr add: kb.
	
	kbr processEvent: evt1.
	kbr processEvent: evt2.
	
	self assert: flag
	
	
	