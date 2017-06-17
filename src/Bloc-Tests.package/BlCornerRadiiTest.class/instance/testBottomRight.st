tests
testBottomRight
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii bottomRight: 10.
	self assert: cornerRadii bottomRight equals: 10.

	cornerRadii := BlCornerRadii radius: 5.
	self assert: cornerRadii bottomRight equals: 5