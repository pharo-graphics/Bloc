*Bloc-Sparta
drawOnSpartaCanvas: aCanvas of: anElement
	"Draw a background of a given element on a provided Sparta Canvas.
	If background is transparent do nothing"

	self isTransparent
		ifTrue: [ ^ self ].

	aCanvas fill
		paint: self fill;
		path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
		draw.

	self image ifNotNil: [ 
		aCanvas fill
			paint: self image;
			path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
			draw ]