predefined instances
SOLID
	^ Solid
		ifNil: [ Solid := self
				lineJoin: BlStrokeLineJoin miter
				lineCap: BlStrokeLineCap butt 
				miterLimit: 10
				dashOffset: 0
				dashArray: #() ]