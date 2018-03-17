tests
testAsArray
	| childrenArray all indices |
	
	childrenArray := self fill: 5.
	all := childrenArray asArray.
	indices := all collect: [ :each | each userData at: #index ].
	self assert: indices equals: #(1 2 3 4 5).
	
	childrenArray := self fill: 0.
	all := childrenArray asArray.
	indices := all collect: [ :each | each userData at: #index ].
	self assert: indices equals: #()