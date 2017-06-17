tests
testBottomLeft
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii bottomLeft: 10.
	self assert: cornerRadii bottomLeft equals: 10.

	cornerRadii := BlCornerRadii radius: 5.
	self assert: cornerRadii bottomLeft equals: 5