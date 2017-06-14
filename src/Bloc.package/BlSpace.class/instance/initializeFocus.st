focus managing
initializeFocus
	self root isFocusable
		ifTrue: [ self root requestFocus ]