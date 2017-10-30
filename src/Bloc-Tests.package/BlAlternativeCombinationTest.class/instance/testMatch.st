tests
testMatch
	<gtExample>
	self setUp.
	
	buffer pressed: false key: Key a.
	buffer pressed: true key: Key b.
	buffer pressed: false key: Key c.
	
	self assert: (combination match: buffer) equals: 0.

	combination key: Key a.
	self assert: (combination match: buffer) equals: 0.
	
	combination key: Key c.
	self assert: (combination match: buffer) equals: 0.
	
	combination key: Key b.
	self assert: (combination match: buffer) equals: 1