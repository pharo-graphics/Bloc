tests
testNoMatchCombinationSequence2
	| kb kbr evt1 evt2 flag |
	flag := false.
	
	evt1 := BlKeyboardEvent new
		charCode: $c;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
	evt2 := BlKeyboardEvent new
		charCode: $d.
		
	kb := BlShortcut new
		combination:(BlCombinationSequence new 
				add: (BlKeyCodeCombination new alt;ctrl;char:$e);
				add: (BlKeyCodeCombination new char:$d) );
		action:[flag := true].
	
	kbr := BlShortcutRegistry new.
	kbr add: kb.
	
	kbr processEvent: evt1.
	kbr processEvent: evt2.
	
	self assert: flag not
	
	
	