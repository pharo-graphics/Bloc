predefined instances
NONE
	^ None
		ifNil: [ None := self
				lineJoin: BlStrokeLineJoin miter
				lineCap: BlStrokeLineCap butt
				miterLimit: 0
				dashOffset: 0
				dashArray: #() ]