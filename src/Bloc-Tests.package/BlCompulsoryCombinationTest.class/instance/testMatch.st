tests
testMatch
	<gtExample>
	self setUp.
	
	buffer pressed: false key: KeyboardKey a.
	buffer pressed: true key: KeyboardKey b.
	buffer pressed: true key: KeyboardKey c.
	
	self assert: (combination match: buffer) equals: 0.

	combination key: KeyboardKey a.
	self assert: (combination match: buffer) equals: 0.
	
	combination key: KeyboardKey c.
	self assert: (combination match: buffer) equals: 1.
	
	combination key: KeyboardKey b.
	self assert: (combination match: buffer) equals: 2