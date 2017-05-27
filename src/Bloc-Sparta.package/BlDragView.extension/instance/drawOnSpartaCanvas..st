*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	
	
	aCanvas transform during: [ :aTransform |
		"apply using ffi call once!"
		aTransform apply.

		aCanvas fill
			paint: background fill;
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			draw.
			
		aCanvas fill
			paint: target;
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			draw.

		aCanvas stroke
			paint: border;
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			width: border width;
			draw ]
	