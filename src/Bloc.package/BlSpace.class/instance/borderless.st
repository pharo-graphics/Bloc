window - properties
borderless
	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace borderless ]
		ifNil: [ borderless ]