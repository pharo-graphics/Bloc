*Bloc-Sparta
drawPathOnSpartaCanvas: aCanvas
	
	aCanvas transform during: [ :aTransform |
		"apply using ffi call once!"
		aTransform apply.
		
		aCanvas stroke
			paint: border;
			path: (self pathOnSpartaCanvas: aCanvas);
			width: border width;
			draw ]
	