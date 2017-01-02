*Bloc-Sparta
drawPathOnSpartaCanvas: aCanvas

	"If background is transparent there is no need to render it"
	background isTransparent
		ifFalse: [ aCanvas fill
				paint: background fill;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				draw ].

	"If border is transparent there is no need to render it"
	border isTransparent
		ifFalse: [ aCanvas stroke
				paint: border stroke;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				width: border stroke width * 2.0;
				draw ]