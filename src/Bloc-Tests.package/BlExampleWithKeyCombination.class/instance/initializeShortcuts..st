initialization
initializeShortcuts: aBuilder
	<shortcuts>
	(aBuilder newShortcutNamed: #copy)
		category: #MyCategory;
		description: 'My super description';
		combination: $c meta asBlKeyCombination;
		action: [ :evt |  ]