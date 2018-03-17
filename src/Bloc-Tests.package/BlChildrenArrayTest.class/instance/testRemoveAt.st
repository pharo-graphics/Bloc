tests
testRemoveAt
	| childrenArray indices |
	
	childrenArray := self fill: 5.
	childrenArray removeAt: 5.
	childrenArray removeAt: 3.
	childrenArray removeAt: 1.
	indices := childrenArray collect: [ :each | each userData at: #index ].
	
	self assert: childrenArray size equals: 2.
	self assert: indices equals: #(2 4)