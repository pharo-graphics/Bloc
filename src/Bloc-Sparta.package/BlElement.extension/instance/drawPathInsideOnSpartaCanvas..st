*Bloc-Sparta
drawPathInsideOnSpartaCanvas: aCanvas
	"I draw border inside"
	| isBackgroundTransparent isBorderTransparent areBothTransparent areBothVisible |
	
	isBackgroundTransparent := background isTransparent.
	isBorderTransparent := border isTransparent.
	areBothTransparent := isBackgroundTransparent and: [ isBorderTransparent ].
	areBothVisible := (isBackgroundTransparent or: [ isBorderTransparent ]) not.

	areBothTransparent
		ifTrue: [ ^ self ].
	
	areBothVisible
		"We create a new virtual layer in order to blend only if background and border visible"
		ifTrue: [ aCanvas layer push ].

	self drawElementOnSpartaCanvas: aCanvas.
	
	"If border is transparent there is no need to render it"
	isBorderTransparent
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
		
	areBothVisible
		"We created a virtual layer only if background and border visible"
		ifTrue: [ aCanvas layer pop ]