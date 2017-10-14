examples - background
rectangleWithImage
	<gtExample>

	^ BlElement new
		size: 400@200;
		relocate: 100 @ 100;
		geometry: (BlRectangle cornerRadius: 10);
		background: self backgroundWithImageAndColor;
		yourself