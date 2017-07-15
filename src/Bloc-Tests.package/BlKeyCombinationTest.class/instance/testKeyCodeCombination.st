tests
testKeyCodeCombination
	| kb kbr evt flag |
	flag := false.
	evt := BlKeyDownEvent new
		key: Key c;
		modifiers:
			(BlKeyModifiers
				shift: false
				ctrl: true
				alt: true
				cmd: false).
	kb := BlShortcut new
		combination:
			(BlKeyCodeCombination new
				alt;
				ctrl;
				key:
					(Key character: $c));
		action: [ flag := true ].
	kbr := BlShortcutRegistry new.
	kbr add: kb.
	kbr processEvent: evt.
	self assert: kb combination modifiers equals: evt modifiers.
	self assert: kb combination key equals: evt key.
	self assert: flag