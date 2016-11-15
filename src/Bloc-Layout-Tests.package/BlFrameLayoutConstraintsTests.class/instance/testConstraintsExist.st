tests
testConstraintsExist
	| constraints |

	self assert: child constraints class equals: BlLayoutCommonConstraints.
	
	constraints := child constraints frame.
	self assert: (constraints isKindOf: BlFrameLayoutConstraints)