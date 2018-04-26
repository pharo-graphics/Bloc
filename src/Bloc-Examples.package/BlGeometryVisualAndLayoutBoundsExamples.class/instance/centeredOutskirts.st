rectangle and start
centeredOutskirts
	<gtExample>
	<label: 'Rectangle and star elements with centered stroke'>
	| aContainer |

	aContainer := self container.
	aContainer addChild: self rectangleWithSmallerGeometryCentered.
	aContainer addChild: self starWithSmallerGeometryCentered.

	^ aContainer