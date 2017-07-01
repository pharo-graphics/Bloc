focus testing
testHasFocusable
	| element child |

	element := self element.
	child := self element.
	element addChild: child.
	
	self assert: element hasFocusable.
	self assert: child hasFocusable.
	
	element visibility: BlVisibility hidden.
	self assert: element hasFocusable.
	self assert: child hasFocusable.
	
	child visibility: BlVisibility hidden.
	self assert: element hasFocusable not.
	self assert: child hasFocusable not.
	
	element visibility: BlVisibility visible.
	self assert: element hasFocusable.
	self assert: child hasFocusable not.
	
	child visibility: BlVisibility visible.
	self assert: element hasFocusable.
	self assert: child hasFocusable