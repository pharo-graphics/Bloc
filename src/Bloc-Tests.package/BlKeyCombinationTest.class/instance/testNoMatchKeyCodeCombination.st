tests
testNoMatchKeyCodeCombination
	| kb kbr evt flag |
	flag := false.
	
	evt := BlKeyDownEvent new
		key: Key c;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: false cmd: false).
		
	kb := 	BlShortcut new 
		combination: (BlKeyCodeCombination new alt;ctrl;char:$c);
		action:[flag := true].
	
	kbr := BlShortcutRegistry new.
	kbr add: kb.
	(kbr processEvent: evt).
	self assert: (kb combination modifiers = evt modifiers) not.
	self assert: kb combination key equals: evt key.
	self assert: flag not
	
	
	