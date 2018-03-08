focus testing
testIsFocusable
	| element |

	element := self element.
	self assert: element isFocusable.
	
	element visibility: BlVisibility gone.
	self assert: element isFocusable not.
	
	element visibility: BlVisibility hidden.
	self assert: element isFocusable not.
	
	element visibility: BlVisibility visible.
	self assert: element isFocusable.
	
	element visibility: BlVisibility visible.
	self assert: element isFocusable.
	
	element preventMouseEvents.
	self assert: element isFocusable not.
	
	element allowMouseEvents.
	self assert: element isFocusable.