tests
testKey
	<gtExample>.
	self setUp.

	self assert: combination combinations isEmpty.
	
	combination key: Key a.
	self assert: (combination combinations asArray collect: #key) equals: { Key a }.
	
	combination key: Key b.
	self assert: (combination combinations asArray collect: #key) equals: { Key a. Key b }.
	
	combination key: Key c.
	self assert: (combination combinations asArray collect: #key) equals: { Key a. Key b. Key c }