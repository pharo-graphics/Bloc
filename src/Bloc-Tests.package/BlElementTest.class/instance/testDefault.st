default
testDefault
	| element |
	
	element := self element.
	
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element geometry extent equals: 0@0