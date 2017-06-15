accessing
windowScale
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | aHostSpace scaleFactor ]
		ifNil: [ 1.0 asPoint ]