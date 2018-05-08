examples - instance creation
scrollPane
	<gtExample>
	
	^ BlScrollableElement new
		size: 300@500;
		clipChildren: false;
		border: (BlBorder builder dashed paint: Color gray; width: 2; build)