tests
testPendingCombinationSequence
	| kb kbr evt1 evt2 flag |
	flag := false.
	
	evt1 := BlKeyboardEvent new
		charCode: $c;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
	evt2 := BlKeyboardEvent new
		charCode: $d.
		
	kb := BlShortcut new
		combination:(BlCombinationSequence new 
				add: (BlKeyCodeCombination new alt;ctrl;char:$c);
				add: (BlKeyCodeCombination new char:$e) );
		action:[flag := true].
	
	kbr := BlShortcutRegistry new.
	kbr add: kb.
	
	kbr processEvent: evt1.
	self assert: kbr pendingShortcuts size = 1.
	
	kbr processEvent: evt2.
	self assert: kbr pendingShortcuts size = 0.
	
	
	