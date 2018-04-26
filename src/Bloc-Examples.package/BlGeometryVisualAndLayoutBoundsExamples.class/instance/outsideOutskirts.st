rectangle and start
outsideOutskirts
	<gtExample>
	<label: 'Rectangle and star elements with outside stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryOutside.
	aContainer addChild: self starWithSmallerGeometryOutside.
		
	^ aContainer