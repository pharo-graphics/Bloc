tests
testMax
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii
		bottomLeft: 5;
		bottomRight: 10;
		topLeft: 15;
		topRight: 20.
	self assert: cornerRadii max equals: 20.
	
	cornerRadii := BlCornerRadii radius: 20.
	self assert: cornerRadii max equals: 20.