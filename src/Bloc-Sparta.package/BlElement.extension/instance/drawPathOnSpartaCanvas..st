*Bloc-Sparta
drawPathOnSpartaCanvas: aCanvas

	aCanvas transform during: [ :aTransform |
		"all matrix modifications happen on image side"
		border applyTransformOnSpartaTransform: aTransform extent: self extent.
		"apply using ffi call once!"
		aTransform apply.

		"If background is transparent there is no need to render it"
		background isTransparent ifFalse: [
			aCanvas fill
				paint: background fill;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				draw ].

		"If border is transparent there is no need to render it"
		border isTransparent ifFalse: [
			aCanvas stroke
				paint: border stroke;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				width: border stroke width;
				draw ] ]
		
		