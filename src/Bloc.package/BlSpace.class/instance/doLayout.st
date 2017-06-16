pulse
doLayout
	| layoutCounter maxLayoutCount |

	self
		assert: [ self isLayoutRequested ]
		description: [ 'Root element must request layout in order to update it' ].

	layoutCounter := 0.
	maxLayoutCount := 100.

	[ self root isLayoutRequested and: [ layoutCounter < maxLayoutCount ] ]
		whileTrue: [
			self doUpdateLayout.
			layoutCounter := layoutCounter + 1 ]