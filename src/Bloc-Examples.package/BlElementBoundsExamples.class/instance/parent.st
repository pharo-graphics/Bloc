instance creation
parent
	<gtExample>
	
	^ BlElement new
		size: self parentExtent;
		relocate: self parentPosition;
		background: (Color gray alpha: 0.3)