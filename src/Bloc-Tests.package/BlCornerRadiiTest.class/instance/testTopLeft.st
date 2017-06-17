tests
testTopLeft
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii topLeft: 10.
	self assert: cornerRadii topLeft equals: 10.

	cornerRadii := BlCornerRadii radius: 5.
	self assert: cornerRadii topLeft equals: 5