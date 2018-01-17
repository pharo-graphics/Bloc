examples
primaryDownSecondaryDownPrimaryUp
	<gtExample>
	| aMouseProcessor anEvent |

	aMouseProcessor := self primaryDownSecondaryDown.
	anEvent := self primaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons size equals: 1.
	self assert: (aMouseProcessor pressedButtons includes: BlMouseButton secondary).

	^ aMouseProcessor