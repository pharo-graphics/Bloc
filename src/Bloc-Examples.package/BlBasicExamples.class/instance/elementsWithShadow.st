examples - shadow
elementsWithShadow
	<gtExample>
	
	^ self container
		addChildren: {
			self rectangleWithShadow relocate: 50@100.
			self ellipseWithShadow relocate: 500 @ 100 }