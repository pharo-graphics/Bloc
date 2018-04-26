rectangle and start
insideOutskirts
	<gtExample>
	<label: 'Rectangle and star elements with inside stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryInside.
	aContainer addChild: self starWithSmallerGeometryInside.
		
	^ aContainer