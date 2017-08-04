tree - deletion
deleteInParent
	"Delete me from the parent"
	self
		assert: [ self hasLeft not and: [ self hasRight not ] ]
		description: [ 'I can not be deleted from the parent if I have children' ].
	
	(self hasParent and: [ self parent isRoot not ])
		ifTrue: [			
			(self parent hasLeft and: [ self parent left == self ])
				ifTrue: [ self parent removeLeft ].
			(self parent hasRight and: [ self parent right == self ])
				ifTrue: [ self parent removeRight ] ].
	
	(self hasParent and: [ self parent isRoot ])
		ifTrue: [ self parent removeRoot ].
	
	"I am deleted and don't have a parent anymore"
	parent := nil