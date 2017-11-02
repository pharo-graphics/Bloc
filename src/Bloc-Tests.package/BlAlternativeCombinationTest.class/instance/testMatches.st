tests
testMatches
	<gtExample>
	self setUp.
	
	buffer pressed: false key: Key a.
	buffer pressed: true key: Key b.
	buffer pressed: false key: Key c.
	
	self assert: (combination matches: buffer) not.
	
	combination key: Key a.
	self assert: (combination matches: buffer) not.
	
	combination key: Key c.
	self assert: (combination matches: buffer) not.
	
	combination key: Key b.
	self assert: (combination matches: buffer)