tree - deletion
delete
	"Delete me from the tree"

	(self hasLeft and: [ self hasRight ])
		ifTrue: [ 
			| successorNode |
			successorNode := self right findMin.
			selection := successorNode selection.
			successorNode delete ]
		ifFalse: [ 
			self hasLeft
				ifTrue: [ self replaceInParent: self left ]
				ifFalse: [ self hasRight
					ifTrue: [ self replaceInParent: self right ]
					ifFalse: [ self deleteInParent ] ] ]