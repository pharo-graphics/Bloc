*Bloc-Sparta
applyOnSpartaCanvas: aSpartaCanvas for: anElement
	aSpartaCanvas fill
		path: anElement effectBounds;
		paint: self paint;
		draw.