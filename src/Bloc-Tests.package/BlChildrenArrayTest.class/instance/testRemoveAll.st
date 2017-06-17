tests
testRemoveAll
	| childrenArray indices |
	
	childrenArray := self fill: 5.
	childrenArray removeAll: {
		childrenArray at: 5.
		childrenArray at: 3.
		childrenArray at: 1.
	}.
	indices := childrenArray all collect: [ :each | each userData at: #index ].
	
	self assert: childrenArray size equals: 2.
	self assert: indices equals: #(2 4)