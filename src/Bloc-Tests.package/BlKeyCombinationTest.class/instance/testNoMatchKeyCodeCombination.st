tests
testNoMatchKeyCodeCombination
	| kb kbr evt flag |
	flag := false.
	
	evt := BlKeyboardEvent new
		charCode: $c asInteger;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: false cmd: false).
		
	kb := 	BlShortcut new 
		combination: (BlKeyCodeCombination new alt;ctrl;char:$c);
		action:[flag := true].
	
	kbr := BlShortcutRegistry new.
	kbr add: kb.
	(kbr processEvent: evt).
	self assert: (kb combination modifiers = evt modifiers) not.
	self assert: kb combination charCode = evt charCode.
	self assert: flag not
	
	
	