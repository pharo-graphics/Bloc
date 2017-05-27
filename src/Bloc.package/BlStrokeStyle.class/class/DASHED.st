predefined instances
DASHED
	^ Dashed
		ifNil: [ Dashed := self
				type: BlBorderType inside
				lineJoin: BlStrokeLineJoin MITER
				lineCap: BlStrokeLineCap round
				miterLimit: 10
				dashOffset: 0
				dashArray: #(6 4.2) ]