tests
testConstraintsConsistent
	| constraintsA constraintsB |
	
	constraintsA := child constraints frame.
	constraintsB := child constraints frame.
	
	"compare by identity to make sure that constraints refer to the same object"
	self assert: constraintsA == constraintsB