examples - instance creation
scrollPaneElement
	<gtExample>
	
	^ BlScrollableElement new
		size: self scrollPaneExtent;
		background: (Color white);
		border: (BlBorder paint: Color darkGray width: 2)