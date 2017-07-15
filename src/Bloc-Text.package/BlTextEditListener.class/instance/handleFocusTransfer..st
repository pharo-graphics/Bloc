focus handlers
handleFocusTransfer: anEvent
	| aTransferBounds aTransferPosition aTextEditElement |
	
	aTextEditElement := anEvent currentTarget.
	
	aTransferBounds := anEvent transfer localBoundsToGlobal: (anEvent transfer focusedBounds: BlBounds new).
	aTransferPosition := aTextEditElement globalPointToLocal: aTransferBounds center.

	self
		moveCursorAtPosition: aTransferPosition
		in: aTextEditElement