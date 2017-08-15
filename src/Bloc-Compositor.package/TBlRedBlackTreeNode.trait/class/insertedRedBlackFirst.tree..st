inserting
insertedRedBlackFirst: aBlackRedNode tree: aRedBlackTree
	"Case 1: The current node N is at the root of the tree.
	In this case, it is repainted black to satisfy property 2 (the root is black).
	Since this adds one black node to every path at once, property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes) is not violated."
	
	aBlackRedNode hasParent
		ifTrue: [ self insertedRedBlackSecond: aBlackRedNode tree: aRedBlackTree ]
		ifFalse: [
			aBlackRedNode beBlack.
			aRedBlackTree root: aBlackRedNode ]