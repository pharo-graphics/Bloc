tree - deletion
replaceInParent: aTextSelectionNode
	"Replace me in a parent with a given node"
	
	self
		assert: [ aTextSelectionNode isNotNil ]
		description: [ 'aTextSelectionNode must not be nil!' ].
	
	(self hasParent and: [ self parent isRoot not ])
		ifTrue: [			
			(self parent hasLeft and: [ self parent left == self ])
				ifTrue: [ self parent left: aTextSelectionNode ].
			(self parent hasRight and: [ self parent right == self ])
				ifTrue: [ self parent right: aTextSelectionNode ] ].
	
	(self hasParent and: [ self parent isRoot ])
		ifTrue: [ self parent root: aTextSelectionNode ].
	
	aTextSelectionNode parent: self parent.
	"I am replaced and don't have a parent anymore"
	parent := nil