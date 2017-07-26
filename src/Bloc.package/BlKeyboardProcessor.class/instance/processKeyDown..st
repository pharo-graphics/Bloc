event processing
processKeyDown: anEvent
	| aTarget aShortcutEvent |

	(self buffer hasEvent: anEvent key)
		ifTrue: [ ^ self ].

	self buffer add: anEvent.
	
	aTarget := self findTarget: anEvent.
	anEvent target: aTarget.
	self fireEvent: anEvent.
	
	aShortcutEvent := BlShortcutEvent new.
	aShortcutEvent buffer: self buffer.
	aShortcutEvent target: aTarget.
	self fireEvent: aShortcutEvent.

	preventKeystrokes := aShortcutEvent isConsumed