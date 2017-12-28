instance creation
child
	<gtExample>
	
	^ BlElement new
		size: self childExtent;
		relocate: self childPosition;
		background: Color red