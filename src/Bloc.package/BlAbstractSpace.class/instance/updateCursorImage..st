cursor managing
updateCursorImage: anImage
	self hostSpace ifNotNil:[:ws|  ws updateCursor: anImage]