predefined instances
DASHED
	^ Dashed
		ifNil: [ Dashed := self
				lineJoin: BlStrokeLineJoin miter
				lineCap: BlStrokeLineCap round
				miterLimit: 10
				dashOffset: 0
				dashArray: #(6 4.2) ]