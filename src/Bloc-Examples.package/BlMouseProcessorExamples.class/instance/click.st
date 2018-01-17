examples - sequence
click
	<gtExample>
	| aMouseProcessor |
	
	aMouseProcessor := self mouseProcessor.

	aMouseProcessor handleMouseDown: self primaryMouseDownEvent.
	aMouseProcessor handleMouseUp: self primaryMouseUpEvent.

	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor