instance creation
resizable
	<gtExample>
	
	^ BlElement new
		size: self initialExtent;
		relocate: self initialPosition;
		background: (Color red alpha: 0.5)