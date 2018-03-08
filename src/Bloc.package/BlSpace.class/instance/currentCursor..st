cursor managing
currentCursor: aCursor

	currentCursor ifNotNil: [ :cc | cc deactivateOn: self ].
	currentCursor := aCursor.
	currentCursor ifNil: [ ^ self updateCursorImage: Cursor normal ].
	currentCursor activateOn: self