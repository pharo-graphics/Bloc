tests
testMatches
	<gtExample>
	self setUp.
	
	buffer pressed: false key: KeyboardKey a.
	buffer pressed: true key: KeyboardKey b.
	buffer pressed: false key: KeyboardKey c.
	
	self assert: (combination matches: buffer) not.
	
	combination key: KeyboardKey a.
	self assert: (combination matches: buffer) not.
	
	combination key: KeyboardKey c.
	self assert: (combination matches: buffer) not.
	
	combination key: KeyboardKey b.
	self assert: (combination matches: buffer)