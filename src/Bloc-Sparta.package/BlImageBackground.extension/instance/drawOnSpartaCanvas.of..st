*Bloc-Sparta
drawOnSpartaCanvas: aCanvas of: anElement
	"Draw a background of a given element on a provided Sparta Canvas.
	If background is transparent do nothing"

	aCanvas fill
		alpha: self opacity;
		paint: (self bitmapOn: aCanvas);
		path: (anElement geometry pathOnSpartaCanvas: aCanvas);
		draw