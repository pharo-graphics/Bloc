tests
testKeyCodeCombination
	| shortcut flag |
	<gtExample>
	self setUp.
	flag := false.
	
	buffer pressed: true key: Key leftControl.
	buffer pressed: false key: Key rightControl.
	buffer pressed: true key: Key leftAlt.
	buffer pressed: false key: Key rightAlt.
	buffer pressed: true key: Key c.
				
	shortcut := BlShortcut new
		combination: (BlKeyCombination builder alt; control; key: Key c; build);
		action: [ flag := true ].

	handler shortcutRegistry add: shortcut.
	handler handleEvent: event.
	
	self assert: flag.

	self tearDown