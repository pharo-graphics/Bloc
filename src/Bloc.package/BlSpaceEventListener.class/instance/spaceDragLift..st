drag and drop
spaceDragLift: anEvent
	| aDelegate aPosition |

	aDelegate := anEvent delegate.
	aPosition := anEvent position.

	aDelegate lift: aPosition in: self space root.

	mouseDragListener := BlEventHandler
		on: BlMouseMoveEvent
		do: [ :aMouseMoveEvent | aDelegate drag: aMouseMoveEvent position ].

	self space addEventHandler: mouseDragListener