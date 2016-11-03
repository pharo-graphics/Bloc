*Bloc-Sparta
drawPathOnSpartaCanvas: aCanvas

	aCanvas transform during: [ :aTransform |
		"all matrix modifications happen on image side"
		border applyTransformOnSpartaTransform: aTransform extent: self extent.
		"apply using ffi call once!"
		aTransform apply.

		aCanvas fill
			paint: background fill;
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			draw.
		
		aCanvas stroke
			paint: border stroke;
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			width: border stroke width;
			draw ]