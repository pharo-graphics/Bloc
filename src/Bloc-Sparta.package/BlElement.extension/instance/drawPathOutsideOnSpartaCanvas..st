*Bloc-Sparta
drawPathOutsideOnSpartaCanvas: aCanvas
	"I draw border outside"

	aCanvas layer
		push.
	
	"If border is transparent there is no need to render it"
	border isTransparent
		ifFalse: [
			aCanvas stroke
				paint: border;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				width: border width * 2.0;
				draw ].
	
	"remove border where we fill"	
	aCanvas clip by: (pathCache geomPathOnSpartaCanvas: aCanvas) during: [ 
		aCanvas fill
			path: (pathCache geomPathOnSpartaCanvas: aCanvas);
			paint: Color white;
			drawOptions: (aCanvas drawOptions composeDestOut; antialiasGray);
			draw ].
	
	self drawElementOnSpartaCanvas: aCanvas.
			
	aCanvas layer pop