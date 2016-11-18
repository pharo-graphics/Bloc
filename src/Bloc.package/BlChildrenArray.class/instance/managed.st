accessing
managed
	^ managedArray ifNil: [ managedArray := self select: [ :e | e isManaged ] ]