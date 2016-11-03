cursor managing
updateCursorImage: anImage
	self hostWindow ifNotNil:[:ws|  ws updateCursor: anImage]