examples - transformation
translate
	<gtExample>
	| element expectedOrigin expectedExtent |
	
	element := self element.
	element transform
		translateBy: 50@50;
		apply.
	
	expectedOrigin := 50@50.
	expectedExtent := self extent.
	
	self
		"transformed bounds, are local bounds with applied transformation matrix on top"
		assert: (element bounds transformed bounds closeTo: (expectedOrigin extent: expectedExtent)).

	self
		"bounds in parent are transformed bounds additionally translated by #position in parent"
		assert: (element bounds inParent bounds closeTo: ((expectedOrigin + self position) extent: expectedExtent)).
	
	^ element