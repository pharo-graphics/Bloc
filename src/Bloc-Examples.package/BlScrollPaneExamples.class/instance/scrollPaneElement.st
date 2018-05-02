examples - instance creation
scrollPaneElement
	<gtExample>
	
	^ BlScrollPane new
		size: self scrollPaneExtent;
		background: (Color white);
		border: (BlBorder paint: Color darkGray width: 2)