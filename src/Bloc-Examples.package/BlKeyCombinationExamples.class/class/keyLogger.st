examples
keyLogger
	<gtExample>

	^ BlElement new
		size: 200@200;
		background: Color red;
		addEventHandler: (BlEventHandler on: BlKeystrokeEvent
			do: [ :anEvent | self inform: 'Keystroke: ', anEvent char asString ]);
		addShortcut: (BlShortcut new
			combination: (BlKeyCombination builder shift; meta; key: Key arrowLeft; build);
			action: [ :aShortcut | self inform: 'Triggered ', aShortcut combination asString ]);
		addShortcut: (BlShortcut new
			combination: (BlSingleKeyCombination key: Key a);
			action: [ self inform: 'Shortcut: a' ]);
		addShortcut: (BlShortcut new
			combination: (BlSingleKeyCombination key: Key arrowUp);
			action: [ self inform: 'Shortcut: arrowUp' ]);
		addShortcut: (BlShortcut new
			combination: (BlKeyCombination builder meta; key: Key arrowUp; build);
			action: [ self inform: 'Shortcut: meta + arrowUp' ]);
		addShortcut: (BlShortcut new
			combination: (BlKeyCombination builder shift; meta; key: Key arrowUp; build);
			action: [ self inform: 'Shortcut: meta + shift + arrowUp' ]);
		requestFocus;
		yourself