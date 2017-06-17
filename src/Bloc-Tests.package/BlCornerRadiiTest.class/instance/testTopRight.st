tests
testTopRight
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii topRight: 10.
	self assert: cornerRadii topRight equals: 10.

	cornerRadii := BlCornerRadii radius: 5.
	self assert: cornerRadii topRight equals: 5