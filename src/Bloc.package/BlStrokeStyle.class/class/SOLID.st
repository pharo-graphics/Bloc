predefined instances
SOLID
	^ Solid
		ifNil: [ Solid := self
				type: BlBorderType inside
				lineJoin: BlStrokeLineJoin MITER
				lineCap: BlStrokeLineCap butt 
				miterLimit: 10
				dashOffset: 0
				dashArray: #() ]