inserting
insertedRedBlackForth: aRedBlackNode tree: aRedBlackTree
	"Case 4: The parent P is red but the uncle U is black; also, the current node N is the right child of P, and P in turn is the left child of its parent G. In this case, a left rotation on P that switches the roles of the current node N and its parent P can be performed; then, the former parent node P is dealt with using case 5 (relabeling N and P) because property 4 (both children of every red node are black) is still violated. The rotation causes some paths (those in the sub-tree labelled '1') to pass through the node N where they did not before. It also causes some paths (those in the sub-tree labelled '3') not to pass through the node P where they did before. However, both of these nodes are red, so property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes) is not violated by the rotation. After this case has been completed, property 4 (both children of every red node are black) is still violated, but now we can resolve this by continuing to case 5."
	| aGrandparent aCurrentNode |
	
	aCurrentNode := aRedBlackNode.
	
	self
		assert: [ aCurrentNode hasGrandparent ]
		description: [ 'A node must have a grandparent!' ].
	
	aGrandparent := aCurrentNode grandparent.
	
	(aCurrentNode == aCurrentNode parent right and: [ aCurrentNode parent == aGrandparent left ])
		ifTrue: [
			self rotateLeft: aCurrentNode parent tree: aRedBlackTree.
			aCurrentNode := aCurrentNode left ]
		ifFalse: [ (aCurrentNode == aCurrentNode parent left and: [ aCurrentNode parent == aGrandparent right ])
			ifTrue: [
				self rotateRight: aCurrentNode parent tree: aRedBlackTree.
				aCurrentNode := aCurrentNode right ] ].
	
	self insertedRedBlackFifth: aCurrentNode tree: aRedBlackTree