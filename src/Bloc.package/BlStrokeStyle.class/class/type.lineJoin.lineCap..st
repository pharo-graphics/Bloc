instance creation
type: aType lineJoin: aLineJoin lineCap: aLineCap
	^ self
		type: aType
		lineJoin: aLineJoin
		lineCap: aLineCap
		miterLimit: 0
		dashOffset: 0
		dashArray: #()