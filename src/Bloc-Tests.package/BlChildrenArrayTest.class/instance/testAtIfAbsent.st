tests
testAtIfAbsent
	| childrenArray |
	
	childrenArray := self fill: 5.
	self assert: ((childrenArray at: 1) userData at: #index) equals: 1.
	self assert: ((childrenArray at: 3) userData at: #index) equals: 3.
	self assert: ((childrenArray at: 5) userData at: #index) equals: 5.
	
	
	self assert: ((childrenArray at: 0 ifAbsent: [
		| anElement |
		anElement := BlElement new.
		anElement userData at: #index put: 0.
		anElement ]) userData at: #index)
	equals: 0.
	
	self assert: ((childrenArray at: 10 ifAbsent: [
		| anElement |
		anElement := BlElement new.
		anElement userData at: #index put: 10.
		anElement ]) userData at: #index)
	equals: 10.