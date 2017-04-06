tests
testKeyCodeCombination
	| kb kbr evt flag |
	flag := false.
	
	evt := BlKeyboardEvent new
		charCode: $c;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
		
	kb := 	BlShortcut new 
		combination: (BlKeyCodeCombination new alt;ctrl;char:$c);
		action:[flag := true].
	
	kbr := BlShortcutRegistry new.
	kbr add: kb.
	(kbr processEvent: evt).
	self assert: kb combination modifiers = evt modifiers.
	self assert: kb combination charCode = evt charCode.
	self assert: flag
	
	
	