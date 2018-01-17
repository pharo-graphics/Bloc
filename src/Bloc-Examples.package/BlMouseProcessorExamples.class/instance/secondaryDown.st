examples
secondaryDown
	<gtExample>
	| aMouseProcessor anEvent |
	
	aMouseProcessor := self mouseProcessor.
	anEvent := self secondaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor