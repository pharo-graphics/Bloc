accessing
match: anEventBuffer
	| isMatching |
	isMatching := self shortcut match: anEventBuffer.
	isMatching
		ifTrue: [ terminated := true ]
		ifFalse: [ terminated := (self shortcut partiallyMatch: anEventBuffer) not ].
	^ isMatching