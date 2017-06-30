instance creation
newSquare
	<gtExample>
	
	^ (BlRectangle length:80) asElement
		background: Color green;
		border: (BlBorder paint: Color black width: 2);
		yourself