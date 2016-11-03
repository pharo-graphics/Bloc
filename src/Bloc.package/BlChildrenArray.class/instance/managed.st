as yet unclassified
managed
	^ managedArray ifNil: [ managedArray := self select: [ :e | e isManaged ] ]