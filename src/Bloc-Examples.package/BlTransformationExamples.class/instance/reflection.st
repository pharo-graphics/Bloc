examples - transformation
reflection
	<gtExample>
	| element |
	
	element := BlBasicExamples new rectangleWithImage.
	element relocate: self position.
	element transform
		flipX;
		flipY;
		apply.

	^ element