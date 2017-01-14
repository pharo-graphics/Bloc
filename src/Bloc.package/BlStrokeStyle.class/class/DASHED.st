predefined instances
DASHED
	^ Dashed
		ifNil: [ Dashed := self
				type: BlStrokeType INSIDE
				lineJoin: BlStrokeLineJoin MITER
				lineCap: BlStrokeLineCap ROUND
				miterLimit: 10
				dashOffset: 0
				dashArray: #(6 4.2) ]