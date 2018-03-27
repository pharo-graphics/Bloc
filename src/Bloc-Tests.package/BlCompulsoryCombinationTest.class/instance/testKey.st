tests
testKey
	<gtExample>.
	self setUp.

	self assert: combination combinations isEmpty.
	
	combination key: KeyboardKey a.
	self assert: (combination combinations asArray collect: #key) equals: { KeyboardKey a }.
	
	combination key: KeyboardKey b.
	self assert: (combination combinations asArray collect: #key) equals: { KeyboardKey a. KeyboardKey b }.
	
	combination key: KeyboardKey c.
	self assert: (combination combinations asArray collect: #key) equals: { KeyboardKey a. KeyboardKey b. KeyboardKey c }