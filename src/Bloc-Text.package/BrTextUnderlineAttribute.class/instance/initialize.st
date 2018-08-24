initialization
initialize
	super initialize.
	
	paint := Color black.
	below := true.
	opacity := 1.
	width := 2.
	style := BlStrokeStyle new
		lineCap: BlStrokeLineCap square;
		lineJoin: BlStrokeLineJoin round;
		miterLimit: 10.0;
		dashArray: #();
		dashOffset: 5