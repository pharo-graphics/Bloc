examples - transformation
rotate
	<gtExample>
	| element expectedOrigin expectedExtent |
	
	element := self element.
	element transform
		rotateBy: 45;
		apply.

	self assert: element extent equals: self extent.
	self assert: element position equals: self position.

	expectedOrigin := (self extent / 2.0) * (1 - 2 sqrt).
	expectedExtent := self extent * (2 sqrt).
	
	self
		"transformed bounds, are local bounds with applied transformation matrix on top"
		assert: (element bounds transformed bounds closeTo: (expectedOrigin extent: expectedExtent)).

	self
		"bounds in parent are transformed bounds additionally translated by #position in parent"
		assert: (element bounds inParent bounds closeTo: ((expectedOrigin + self position) extent: expectedExtent)).

	^ element