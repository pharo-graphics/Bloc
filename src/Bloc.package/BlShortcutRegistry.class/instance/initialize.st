initialization
initialize
	super initialize.
	eventBuffer := BlEventBuffer new.
	shortcuts := OrderedCollection new.
	pendingShortcuts := OrderedCollection new.