*Bloc-Sparta
drawPathInsideOnSpartaCanvas: aCanvas
	"I draw border inside"

	aCanvas layer
		push.

	"If background is transparent there is no need to render it"
	background isTransparent
		ifFalse: [ aCanvas fill
				paint: background fill;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				draw ].
	
	"If border is transparent there is no need to render it"
	border isTransparent
		ifFalse: [ aCanvas clip by: (pathCache geomPathOnSpartaCanvas: aCanvas) during: [
			"remove background where we will stroke"
			aCanvas stroke
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				width: border width * 2.0;
				paint: Color white;
				drawOptions: (aCanvas drawOptions composeDestOut; antialiasGray);
				draw.
			"actually draw border"
			aCanvas stroke
				paint: border;
				width: border width * 2.0;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				draw ] ].

	aCanvas layer pop