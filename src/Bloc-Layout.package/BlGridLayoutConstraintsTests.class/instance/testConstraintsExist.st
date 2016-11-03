tests
testConstraintsExist
	| constraints |

	self assert: child constraints class equals: BlLayoutCommonConstraints.
	
	constraints := child constraints grid.
	self assert: (constraints isKindOf: BlGridLayoutConstraints)