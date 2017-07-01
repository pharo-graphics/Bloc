tests
testCombinationAlternative2
	| kb kbr evt1 evt2 evt3 flag |
	flag := false.

	evt1 := BlKeyDownEvent new
		key: Key c;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
	evt2 := BlKeyDownEvent new
		key: Key d;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
	evt3 := BlKeyDownEvent new
		key: Key e;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).

	kb := BlShortcut new
		combination:( BlCombinationAlternative new
			add: (BlCombinationSequence new 
				add: (BlKeyCodeCombination new alt;ctrl;char: $c);
				add: (BlKeyCodeCombination new alt;ctrl;char: $e) );
			add:(BlKeyCodeCombination new alt;ctrl;char: $d));
	   action:[flag := true].
	
	kbr := BlShortcutRegistry new.
	kbr add: kb.
	
	kbr processEvent: evt1.
	kbr processEvent: evt2.
	
	self assert: flag.
	flag := false.
	
	kbr processEvent: evt3.
	self assert: flag not.
	
	
	