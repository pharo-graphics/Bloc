cursor managing
updateCursorImage: anImage

	self hostSpace ifNotNil: [ :aHostSpace |
		aHostSpace cursor: anImage ]