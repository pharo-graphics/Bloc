predefined instances
DOTTED
	^ Dotted
		ifNil: [ Dotted := self
				type: BlStrokeType INSIDE
				lineJoin: BlStrokeLineJoin MITER
				lineCap: BlStrokeLineCap ROUND
				miterLimit: 10
				dashOffset: 0
				dashArray: #(0 4) ]