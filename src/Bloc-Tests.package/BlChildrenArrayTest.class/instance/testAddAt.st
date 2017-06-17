tests
testAddAt
	| childrenArray indices element |
	
	childrenArray := self fill: 0.

	element := BlElement new.
	element userData at: #index put: 1.
	childrenArray add: element at: 1.
	indices := childrenArray all collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 1.
	self assert: indices equals: #(1).
	
	element := BlElement new.
	element userData at: #index put: 2.
	childrenArray add: element at: 1.
	indices := childrenArray all collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 2.
	self assert: indices equals: #(2 1).
	
	element := BlElement new.
	element userData at: #index put: 3.
	childrenArray add: element at: 2.
	indices := childrenArray all collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 3.
	self assert: indices equals: #(2 3 1).
	
	element := BlElement new.
	element userData at: #index put: 4.
	childrenArray add: element at: 4.
	indices := childrenArray all collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 4.
	self assert: indices equals: #(2 3 1 4)