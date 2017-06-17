tests
testRemove
	| childrenArray indices |
	
	childrenArray := self fill: 5.
	childrenArray remove: (childrenArray at: 3).
	indices := childrenArray all collect: [ :each | each userData at: #index ].
	
	self assert: (childrenArray size) equals: 4.
	self assert: indices equals: #(1 2 4 5)