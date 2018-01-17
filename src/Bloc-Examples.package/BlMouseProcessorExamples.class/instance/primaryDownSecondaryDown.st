examples
primaryDownSecondaryDown
	<gtExample>
	| aMouseProcessor anEvent |

	aMouseProcessor := self primaryDown.
	anEvent := self secondaryMouseDownEvent.

	aMouseProcessor handleMouseDown: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 2.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton primary).
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor