as yet unclassified
testCombinationAlternative
	| kb kbr evt1 evt2 evt3 flag |
	flag := false.
	
	evt1 := BlKeyboardEvent new
		charCode: $c asInteger;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
	evt2 := BlKeyboardEvent new
		charCode: $d asInteger;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
	evt3 := BlKeyboardEvent new
		charCode: $e asInteger;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
		
	kb := 	(($c alt control),($d alt ctrl)| ($e alt control)) asBlKeyCombination.
		
	kb action:[flag := true].
	
	kbr := BlKeyCombinationRegistry new.
	kbr add: kb.
	
	kbr processEvent: evt1.
	kbr processEvent: evt2.
	
	self assert: flag.
	flag := false.
	
	kbr processEvent: evt3.
	self assert: flag.
	
	
	