focus testing
testIsFocused
	| element |
	
	element := self element.
	
	space root addChild: element.
	self assert: element isFocused not.

	element focused: true.
	self assert: element isFocused