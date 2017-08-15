tree - inserting
insert: aRedBlackNode
	"Insert a given node in red-black tree balancing the latter"

	self hasRoot
		ifTrue: [ self root insertBinary: aRedBlackNode ]
		ifFalse: [ self root: aRedBlackNode ].
		
	aRedBlackNode class insertedRedBlackFirst: aRedBlackNode tree: self