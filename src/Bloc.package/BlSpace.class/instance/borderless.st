accessing
borderless
	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace borderless ]
		ifNil: [ borderless ]