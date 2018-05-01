private - instance creation
animatedElement
	<gtExample>
	
	^ BlElement new
		background: Color blue;
		size: 150@150;
		relocate: 100@100;
		addAnimation: self infiniteAnimation