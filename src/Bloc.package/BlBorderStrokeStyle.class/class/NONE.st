predefined instances
NONE
	^ None
		ifNil: [ None := self
				type: BlStrokeType INSIDE
				lineJoin: BlStrokeLineJoin MITER
				lineCap: BlStrokeLineCap BUTT
				miterLimit: 0
				dashOffset: 0
				dashArray: #() ]