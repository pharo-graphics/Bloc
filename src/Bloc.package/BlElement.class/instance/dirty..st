accessing private
dirty: aBoolean
	dirty = aBoolean ifTrue: [ ^ self ].
	dirty := aBoolean.
	dirty ifTrue: [ self parent ifNotNil: [ :p | p dirty: true ] ]