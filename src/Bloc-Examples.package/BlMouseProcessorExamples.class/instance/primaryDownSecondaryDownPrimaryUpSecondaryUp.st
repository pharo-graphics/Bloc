examples
primaryDownSecondaryDownPrimaryUpSecondaryUp
	<gtExample>
	| aMouseProcessor anEvent |

	aMouseProcessor := self primaryDownSecondaryDownPrimaryUp.
	anEvent := self secondaryMouseUpEvent.

	aMouseProcessor handleMouseUp: anEvent.

	self assert: aMouseProcessor pressedButtons isEmpty.

	^ aMouseProcessor