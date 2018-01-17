examples
middleDown
	<gtExample>
	| aMouseProcessor anEvent |
	
	aMouseProcessor := self mouseProcessor.
	anEvent := self middleMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton middle).

	^ aMouseProcessor