accessing private
dirty: aBoolean
	dirty := aBoolean.
	dirty ifTrue:[self parent ifNotNil:[:p| p dirty: true]].