examples
middleRightResize
	<gtExample>
	| container vector |
	
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.
	
	BlSpace simulateDragOn: (container childNamed: #resizer) middleRight by: vector.

	self assert: (container childNamed: #resizable) extent equals: self initialExtent + (vector x @ 0).
	self assert: (container childNamed: #resizable) position equals: self initialPosition.

	^ container