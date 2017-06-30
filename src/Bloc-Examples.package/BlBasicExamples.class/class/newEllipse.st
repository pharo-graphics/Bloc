instance creation
newEllipse
	<gtExample>
	
	^ (BlEllipse extent: 200 @ 100) asElement
		background: (Color red alpha: 0.5);
		border: (BlBorder paint: Color black width: 2);
		yourself