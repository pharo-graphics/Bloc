tests
testMin
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii
		bottomLeft: 5;
		bottomRight: 10;
		topLeft: 15;
		topRight: 20.
	self assert: cornerRadii min equals: 5.
	
	cornerRadii := BlCornerRadii radius: 20.
	self assert: cornerRadii min equals: 20.