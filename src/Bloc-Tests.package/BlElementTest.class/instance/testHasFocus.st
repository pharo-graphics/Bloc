focus testing
testHasFocus
	| element child |
	
	element := self element.
	child := self element.
	
	element addChild: child.
	space root addChild: element.
	self assert: element hasFocus not.
	self assert: child hasFocus not.

	element focused: true.
	self assert: element hasFocus.
	self assert: child hasFocus not.
	
	element focused: false.
	child focused: true.
	
	self assert: element hasFocus.
	self assert: child hasFocus.