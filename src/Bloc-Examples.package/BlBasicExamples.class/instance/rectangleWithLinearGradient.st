examples - background
rectangleWithLinearGradient
	<gtExample>

	^ BlElement new
		size: 300@200;
		relocate: 100 @ 100;
		geometry: (BlRectangle cornerRadius: 40);
		background: self linearGradient;
		yourself