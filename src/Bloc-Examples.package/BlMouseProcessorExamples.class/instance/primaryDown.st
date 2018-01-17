examples
primaryDown
	<gtExample>
	| aMouseProcessor anEvent |
	
	aMouseProcessor := self mouseProcessor.
	anEvent := self primaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton primary).

	^ aMouseProcessor