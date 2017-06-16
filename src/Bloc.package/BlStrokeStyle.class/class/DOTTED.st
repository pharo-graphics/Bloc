predefined instances
DOTTED
	^ Dotted
		ifNil: [ Dotted := self
				lineJoin: BlStrokeLineJoin miter
				lineCap: BlStrokeLineCap round
				miterLimit: 10
				dashOffset: 0
				dashArray: #(0 4) ]