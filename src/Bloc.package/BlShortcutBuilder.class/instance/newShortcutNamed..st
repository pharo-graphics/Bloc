instance creation
newShortcutNamed: aSymbol
	| newShortcut |
	newShortcut := BlShortcut new.
	newShortcut name: aSymbol.
	^ newShortcut