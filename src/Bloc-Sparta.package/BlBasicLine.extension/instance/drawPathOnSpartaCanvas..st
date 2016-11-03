*Bloc-Sparta
drawPathOnSpartaCanvas: aCanvas
	
	aCanvas transform during: [ :aTransform |
		"apply using ffi call once!"
		aTransform apply.
		
		aCanvas stroke
			paint: border stroke;
			path: (self pathOnSpartaCanvas: aCanvas);
			width: border stroke width;
			draw ]
	