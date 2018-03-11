examples
topRightResize
	<gtExample>
	| container vector |
	
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.
	
	BlSpace simulateDragOn: (container childNamed: #resizer) topRight by: vector.

	self assert: (container childNamed: #resizable) extent equals: self initialExtent + (vector x @ (0 - vector y)).
	self assert: (container childNamed: #resizable) position equals: self initialPosition + (0 @ vector y).

	^ container