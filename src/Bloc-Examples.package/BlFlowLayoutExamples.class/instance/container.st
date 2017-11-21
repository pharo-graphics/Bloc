instance creation
container
	<gtExample>
	
	^ BlElement new
		layout: BlFlowLayout new horizontal;
		border: (BlBorder paint: Color lightGray width: 8);
		background: Color white darker