*Bloc-Sparta
drawOnSpartaCanvas: aCanvas of: anElement

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