*Bloc-Sparta
drawPathOnSpartaCanvas: aCanvas
	"I draw border outside"
	
	aCanvas layer
		push.
	
	"If border is transparent there is no need to render it"
	border isTransparent
		ifFalse: [ aCanvas stroke
				paint: border stroke;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				width: border stroke width * 2.0;
				draw ].
	
	"remove border where we fill"	
	aCanvas clip by: (pathCache geomPathOnSpartaCanvas: aCanvas) during: [ 
		aCanvas fill
		path: (pathCache geomPathOnSpartaCanvas: aCanvas);
		paint: Color white;
		drawOptions: (aCanvas drawOptions composeDestOut; antialiasGray);
		draw.
	].
	
	"If background is transparent there is no need to render it"
	background isTransparent
		ifFalse: [ aCanvas fill
				paint: background fill;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				draw ].
			
	aCanvas layer pop