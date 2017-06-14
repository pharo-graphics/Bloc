window - properties
resizable
	"Return true if underlying window is resizable, false otherwise"
	<return: #Boolean>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace resizable ]
		ifNil: [ resizable ]