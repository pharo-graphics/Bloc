inserting
insertedRedBlackFifth: aRedBlackNode tree: aRedBlackTree
	"Case 5: The parent P is red but the uncle U is black, the current node N is the left child of P, and P is the left child of its parent G. In this case, a right rotation on G is performed; the result is a tree where the former parent P is now the parent of both the current node N and the former grandparent G. G is known to be black, since its former child P could not have been red otherwise (without violating property 4). Then, the colors of P and G are switched, and the resulting tree satisfies property 4 (both children of every red node are black). Property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes) also remains satisfied, since all paths that went through any of these three nodes went through G before, and now they all go through P. In each case, this is the only black node of the three."
	
	| aGrandparent |
	
	aGrandparent := aRedBlackNode grandparent.
	aRedBlackNode parent beBlack.
	aGrandparent beRed.
	
	aRedBlackNode == aRedBlackNode parent left
		ifTrue: [ self rotateRight: aGrandparent tree: aRedBlackTree ]
		ifFalse: [ self rotateLeft: aGrandparent tree: aRedBlackTree ]