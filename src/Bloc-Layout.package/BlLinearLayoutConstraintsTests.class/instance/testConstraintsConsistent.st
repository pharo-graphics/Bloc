tests
testConstraintsConsistent
	| constraintsA constraintsB |
	
	constraintsA := child constraints linear.
	constraintsB := child constraints linear.
	
	"compare by identity to make sure that constraints refer to the same object"
	self assert: constraintsA == constraintsB