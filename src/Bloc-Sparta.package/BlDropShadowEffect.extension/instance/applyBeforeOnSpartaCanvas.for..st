*Bloc-Sparta
applyBeforeOnSpartaCanvas: anSpartaCanvas for: anElement
	|shadowCanvas|
	shadowCanvas := anSpartaCanvas similar: anElement fxBounds extent.
		
	shadowCanvas transform
		push;
		translateBy: ((self offset ) max: 0@0 );
		apply.	
	shadowCanvas fill
		paint: self color ;
		path: (anElement pathCache geomPathOnSpartaCanvas: shadowCanvas);
		draw.
		
	anSpartaCanvas filter
		area: anElement fxBounds;
		type: (shadowCanvas gaussianBlurFilter
			stdDeviation: ((self width/2) asFloat max: 0);
			source: shadowCanvas surface);
		drawOptions: (shadowCanvas drawOptions
			alpha: 1);
		draw.
		
	shadowCanvas transform pop.
	
	