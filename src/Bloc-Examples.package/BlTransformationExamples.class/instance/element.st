instance creation
element
	<gtExample>
	
	^ BlElement new
		background: Color blue;
		size: self extent;
		relocate: self position;
		forceLayout "to compute extent and position"