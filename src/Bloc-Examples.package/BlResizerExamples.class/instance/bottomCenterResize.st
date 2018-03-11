examples
bottomCenterResize
	<gtExample>
	| container vector |
	
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.
	
	BlSpace simulateDragOn: (container childNamed: #resizer) bottomCenter by: vector.

	self assert: (container childNamed: #resizable) extent equals: self initialExtent + (0 @ vector y).
	self assert: (container childNamed: #resizable) position equals: self initialPosition.

	^ container