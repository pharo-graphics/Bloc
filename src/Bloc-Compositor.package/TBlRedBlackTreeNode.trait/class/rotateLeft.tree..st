rotation
rotateLeft: aRedBlackNode tree: aRedBlackTree
	"Perform a left rotation of a given node in a tree according to
	Introduction to Algorithms p.313 by Thomas H. Cormen"
	| aRight |
	
	self
		assert: [ aRedBlackNode hasRight ]
		description: [ 'A node must have right node in order to be left rotated' ].
	
	aRight := aRedBlackNode right.
	aRedBlackNode right: aRight left.
	
	aRight hasLeft
		ifTrue: [ aRight left parent: aRedBlackNode ].
	aRight parent: aRedBlackNode parent.
	
	aRedBlackNode hasParent
		ifFalse: [ aRedBlackTree root: aRight ]
		ifTrue: [ aRedBlackNode == aRedBlackNode parent left
			ifTrue: [ aRedBlackNode parent left: aRight ]
			ifFalse: [ aRedBlackNode parent right: aRight ] ].
		
	aRight left: aRedBlackNode.
	aRedBlackNode parent: aRight