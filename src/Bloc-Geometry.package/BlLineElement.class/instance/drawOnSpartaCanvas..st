drawing
drawOnSpartaCanvas: aCanvas

	aCanvas stroke
		alpha: self border opacity;
		paint: self border paint;
		path: (aCanvas shape line: self geometry from to: self geometry to);
		width: self border width;
		in: [ :aPainter | self border style applyOn: aPainter ];
		draw