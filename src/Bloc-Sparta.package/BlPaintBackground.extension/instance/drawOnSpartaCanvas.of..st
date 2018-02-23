*Bloc-Sparta
drawOnSpartaCanvas: aCanvas of: anElement
	"Draw a background of a given element on a provided Sparta Canvas.
	If background is transparent do nothing"

	self isTransparent
		ifTrue: [ ^ self ].

	aCanvas fill
		alpha: self opacity;
		paint: self paint;
		path: (anElement geometry pathOnSpartaCanvas: aCanvas);
		draw