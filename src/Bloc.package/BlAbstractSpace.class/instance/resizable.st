accessing
resizable

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace resizable ]
		ifNil: [ resizable ]