predefined instances
DOTTED
	^ Dotted
		ifNil: [ Dotted := self
				type: BlBorderType inside
				lineJoin: BlStrokeLineJoin MITER
				lineCap: BlStrokeLineCap round
				miterLimit: 10
				dashOffset: 0
				dashArray: #(0 4) ]