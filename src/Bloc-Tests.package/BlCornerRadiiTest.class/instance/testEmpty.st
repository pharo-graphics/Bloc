tests
testEmpty
	| cornerRadii |
	
	BlCornerRadii cleanUp.
	cornerRadii := BlCornerRadii empty.
	
	self assert: cornerRadii bottomLeft equals: 0.
	self assert: cornerRadii bottomRight equals: 0.
	self assert: cornerRadii topLeft equals: 0.
	self assert: cornerRadii topRight equals: 0