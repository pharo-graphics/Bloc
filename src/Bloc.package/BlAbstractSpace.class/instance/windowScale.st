accessing
windowScale
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Number>

	^ self hostSpace
		ifNotNil: [ :aHostSpace | (aHostSpace extent / aHostSpace windowExtent) asFloatPoint ]
		ifNil: [ 1.0 asPoint ]