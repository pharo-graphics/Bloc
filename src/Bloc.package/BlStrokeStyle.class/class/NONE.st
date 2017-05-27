predefined instances
NONE
	^ None
		ifNil: [ None := self
				type: BlBorderType inside
				lineJoin: BlStrokeLineJoin MITER
				lineCap: BlStrokeLineCap butt
				miterLimit: 0
				dashOffset: 0
				dashArray: #() ]