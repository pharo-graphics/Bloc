rotation
rotateRight: aRedBlackNode tree: aRedBlackTree
	"Perform a right rotation of a given node in a tree according to
	Introduction to Algorithms p.313 by Thomas H. Cormen"
	| aLeft |
	
	self
		assert: [ aRedBlackNode hasLeft ]
		description: [ 'A node must have right node in order to be left rotated' ].
	
	aLeft := aRedBlackNode left.
	aRedBlackNode left: aLeft right.
	
	aLeft hasRight
		ifTrue: [ aLeft right parent: aRedBlackNode ].
	aLeft parent: aRedBlackNode parent.
	
	aRedBlackNode hasParent
		ifFalse: [ aRedBlackTree root: aLeft ]
		ifTrue: [ aRedBlackNode == aRedBlackNode parent right
			ifTrue: [ aRedBlackNode parent right: aLeft ]
			ifFalse: [ aRedBlackNode parent left: aLeft ] ].
		
	aLeft right: aRedBlackNode.
	aRedBlackNode parent: aLeft