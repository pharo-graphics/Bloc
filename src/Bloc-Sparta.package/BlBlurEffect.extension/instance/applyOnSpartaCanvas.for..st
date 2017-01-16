*Bloc-Sparta
applyOnSpartaCanvas: aSpartaCanvas for: anElement
	| anEffectBounds |
	
	anEffectBounds := anElement localBoundsToGlobal: (anElement effectBounds: SpartaRectangle new).
	aSpartaCanvas filter
		area: anEffectBounds; "source in gloabl coordiante of canvas"
		to: 0@0; "destination in local coordinates of canvas"
		type: (aSpartaCanvas gaussianBlurFilter
			stdDeviation: self radius;
			source: aSpartaCanvas);
		draw