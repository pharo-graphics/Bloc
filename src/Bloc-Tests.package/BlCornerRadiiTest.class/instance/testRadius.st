tests
testRadius
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii radius: 10.
	
	self assert: cornerRadii bottomLeft equals: 10.
	self assert: cornerRadii bottomRight equals: 10.
	self assert: cornerRadii topLeft equals: 10.
	self assert: cornerRadii topRight equals: 10.