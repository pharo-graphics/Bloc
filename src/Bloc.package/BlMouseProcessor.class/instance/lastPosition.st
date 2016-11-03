accessing
lastPosition
	lastMouseEvent ifNil: [ ^ 0 @ 0 ].
	^ lastMouseEvent position