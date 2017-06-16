builder
build
	^ BlBorder new
		paint: self paint;
		width: self width;
		style: self buildStyle;
		opacity: self opacity;
		yourself