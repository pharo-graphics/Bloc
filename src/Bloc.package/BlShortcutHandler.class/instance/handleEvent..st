events
handleEvent: aShortcutEvent
	| matchingShortcuts |

	"no process for repeated key events"
	aShortcutEvent repeat isZero
		ifFalse: [ ^ self ].

	matchingShortcuts := self shortcuts
		select: [ :aShortcut | aShortcut matches: aShortcutEvent buffer ]
		thenCollect: [ :aShortcut | aShortcut -> (aShortcut match: aShortcutEvent buffer) ].
	matchingShortcuts sort: [ :a :b | a value > b value ].

	matchingShortcuts
		ifNotEmpty: [ :theShortcuts |
			| aShortcut |
			aShortcut := matchingShortcuts first key.
			aShortcut action cull: aShortcut.
			aShortcutEvent consumed: true ]