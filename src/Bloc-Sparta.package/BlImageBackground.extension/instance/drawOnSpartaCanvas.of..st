*Bloc-Sparta
drawOnSpartaCanvas: aCanvas of: anElement
	"Draw a background of a given element on a provided Sparta Canvas.
	If background is transparent do nothing"

	aCanvas fill
		alpha: self opacity;
		paint: self image;
		path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
		draw