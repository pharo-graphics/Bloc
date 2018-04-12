tree - searching
findMin
	"Return a minimum node in a subtree"
	<return: #BltextSelectionNode>
	| aCurrentNode |
	
	aCurrentNode := self.
	[ aCurrentNode hasLeft ]
		whileTrue: [ aCurrentNode := aCurrentNode left ].
	^ aCurrentNode