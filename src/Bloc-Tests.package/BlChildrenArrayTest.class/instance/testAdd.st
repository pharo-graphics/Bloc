tests
testAdd
	| childrenArray indices element |
	
	childrenArray := self fill: 0.

	element := BlElement new.
	element userData at: #index put: 1.
	childrenArray add: element.
	indices := childrenArray all collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 1.
	self assert: indices equals: #(1).
	
	element := BlElement new.
	element userData at: #index put: 2.
	childrenArray add: element.
	indices := childrenArray all collect: [ :each | each userData at: #index ].
	self assert: childrenArray size equals: 2.
	self assert: indices equals: #(1 2)