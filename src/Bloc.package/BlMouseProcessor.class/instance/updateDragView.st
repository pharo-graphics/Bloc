event processing
updateDragView
|dv|
	self space dragboard ifNil:[^ self].
	dv := self space dragboard dragView ifNil:[^ self ].
	dv updateFromCursorPosition: self lastPosition.