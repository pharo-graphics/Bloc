*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	
	
	aCanvas transform during: [ :aTransform |
		"apply using ffi call once!"
		aTransform apply.

		aCanvas fill
			paint: self background fill;
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			draw.
			
		aCanvas fill
			paint: target;
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			draw.

		aCanvas stroke
			paint: self border;
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			width: self border width;
			draw ]
	