as yet unclassified
testKeyCodeCombination
	| kb kbr evt flag |
	flag := false.
	
	evt := BlKeyboardEvent new
		charCode: $c asInteger;
		modifiers: (BlKeyModifiers shift: false ctrl: true alt: true cmd: false).
		
	kb := 	BlKeyCodeCombination new alt;ctrl;char:$c.
	kb action:[flag := true].
	
	kbr := BlKeyCombinationRegistry new.
	kbr add: kb.
	(kbr processEvent: evt).
	self assert: kb modifiers = evt modifiers.
	self assert: kb charCode = evt charCode.
	self assert: flag
	
	
	