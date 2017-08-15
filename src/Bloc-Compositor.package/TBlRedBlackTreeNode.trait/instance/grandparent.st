accessing
grandparent
	"Return my grandparent node.
	Note: You must always check if I have a grandparent before using me"
	<return: #TBlRedBlackTreeNode>
	
	self
		assert: [ self hasGrandparent ]
		description: [ 'I must have grandparent to return it' ].
		
	^ self parent parent