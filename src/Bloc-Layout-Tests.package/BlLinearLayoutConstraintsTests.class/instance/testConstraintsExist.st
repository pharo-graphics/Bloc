tests
testConstraintsExist
	| constraints |

	self assert: child constraints class equals: BlLayoutCommonConstraints.
	
	constraints := child constraints linear.
	self assert: (constraints isKindOf: BlLinearLayoutConstraints)