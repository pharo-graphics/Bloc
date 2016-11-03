adding
addInlineLast: aChild
	self
		assert: [ aChild isInline ]
		description: [ 'I can only be used to add inlined children!' ].

	children addLast: aChild.
	
	length := length + aChild length + aChild spacingLength.
	breadth := breadth max: aChild breadth + aChild spacingBreadth