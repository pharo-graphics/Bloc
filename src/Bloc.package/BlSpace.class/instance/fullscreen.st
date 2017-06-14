window - properties
fullscreen
	"Return true if an underlying window is in fullscreen mode,
	false otherwise"
	<return: #Boolean>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace fullscreen ]
		ifNil: [ fullscreen ]