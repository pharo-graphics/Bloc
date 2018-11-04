Extension { #name : #BlDragView }

{ #category : #'*Bloc-Sparta' }
BlDragView >> drawOnSpartaCanvas: aCanvas [
	aCanvas fill
		paint: self background fill;
		path: (self geometry pathOnSpartaCanvas: aCanvas);
		draw.
			
	aCanvas fill
		paint: target;
		path: (self geometry pathOnSpartaCanvas: aCanvas);
		draw.

	aCanvas stroke
		paint: self border;
		path: (self geometry pathOnSpartaCanvas: aCanvas);
		width: self border width;
		draw
]
