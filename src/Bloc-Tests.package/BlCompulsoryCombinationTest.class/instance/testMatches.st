tests
testMatches
	<gtExample>.
	self setUp.

	buffer pressed: true key: Key a.
	buffer pressed: false key: Key b.
	buffer pressed: true key: Key c.
	
	self assert: (combination matches: buffer) not.
	
	combination key: Key a.
	self assert: (combination matches: buffer).
	
	combination key: Key c.
	self assert: (combination matches: buffer).
	
	combination key: Key b.
	self assert: (combination matches: buffer) not