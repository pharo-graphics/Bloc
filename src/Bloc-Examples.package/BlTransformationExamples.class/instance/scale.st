examples - transformation
scale
	<gtExample>
	| element expectedOrigin expectedExtent |
	
	element := self element.
	element transform
		scaleBy: 2@2;
		apply.

	expectedOrigin := (self extent / 2.0) negated.
	expectedExtent := self extent * 2.
	
	self
		"transformed bounds, are local bounds with applied transformation matrix on top"
		assert: (element bounds transformed bounds closeTo: (expectedOrigin extent: expectedExtent)).

	self
		"bounds in parent are transformed bounds additionally translated by #position in parent"
		assert: (element bounds inParent bounds closeTo: ((expectedOrigin + self position) extent: expectedExtent)).

	^ element