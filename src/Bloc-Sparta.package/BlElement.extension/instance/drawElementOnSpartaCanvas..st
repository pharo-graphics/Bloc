*Bloc-Sparta
drawElementOnSpartaCanvas: aCanvas
	"If background is transparent there is no need to render it"
	background isTransparent
		ifFalse: [
			aCanvas fill
				paint: background fill;
				path: (pathCache geomPathOnSpartaCanvas: aCanvas);
				draw.
			
			background image ifNotNil: [ 
				aCanvas fill
					paint: background image;
					path: (pathCache geomPathOnSpartaCanvas: aCanvas);
					draw
			]
	].