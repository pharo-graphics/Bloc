private - inserting
insertedRedBlackSecond
	"Case 2: The current node's parent P is black, so property 4 (both children of every red node are black) is not invalidated.
	In this case, the tree is still valid.
	Property 5 (all paths from any given node to its leaf nodes contain the same number of black nodes) is not threatened,
	because the current node N has two black leaf children, but because N is red,
	the paths through each of its children have the same number of black nodes as the path through the leaf it replaced,
	which was black, and so this property remains satisfied."
	
	self
		assert: [ self hasParent ]
		description: [ 'Case 2 is only valid if I have a parent' ].
	
	"Tree is still valid"
	self parent isBlack
		ifTrue: [ ^ self ].
	
	self insertedRedBlackThird
	