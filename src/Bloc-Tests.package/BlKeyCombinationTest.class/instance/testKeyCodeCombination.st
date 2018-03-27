tests
testKeyCodeCombination
	| shortcut flag |
	<gtExample>
	self setUp.
	flag := false.
	
	buffer pressed: true key: KeyboardKey leftControl.
	buffer pressed: false key: KeyboardKey rightControl.
	buffer pressed: true key: KeyboardKey leftAlt.
	buffer pressed: false key: KeyboardKey rightAlt.
	buffer pressed: true key: KeyboardKey c.
				
	shortcut := BlShortcut new
		combination: (BlKeyCombination builder alt; control; key: KeyboardKey c; build);
		action: [ flag := true ].

	handler shortcutRegistry add: shortcut.
	handler handleEvent: event.
	
	self assert: flag.