tests
testConstraintsConsistent
	| constraintsA constraintsB |
	
	constraintsA := child constraints grid.
	constraintsB := child constraints grid.
	
	"compare by identity to make sure that constraints refer to the same object"
	self assert: constraintsA == constraintsB