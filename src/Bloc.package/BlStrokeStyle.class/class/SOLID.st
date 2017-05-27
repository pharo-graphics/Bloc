predefined instances
SOLID
	^ Solid
		ifNil: [ Solid := self
				type: BlStrokeType INSIDE
				lineJoin: BlStrokeLineJoin MITER
				lineCap: BlStrokeLineCap BUTT 
				miterLimit: 10
				dashOffset: 0
				dashArray: #() ]