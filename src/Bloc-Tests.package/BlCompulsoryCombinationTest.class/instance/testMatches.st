tests
testMatches
	<gtExample>.
	self setUp.

	buffer pressed: true key: KeyboardKey a.
	buffer pressed: false key: KeyboardKey b.
	buffer pressed: true key: KeyboardKey c.
	
	self assert: (combination matches: buffer) not.
	
	combination key: KeyboardKey a.
	self assert: (combination matches: buffer).
	
	combination key: KeyboardKey c.
	self assert: (combination matches: buffer).
	
	combination key: KeyboardKey b.
	self assert: (combination matches: buffer) not