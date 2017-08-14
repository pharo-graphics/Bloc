tree - searching
findMax
	"Return a minimum node in a subtree"
	<return: #BltextSelectionNode>
	| aCurrentNode |
	
	aCurrentNode := self.
	[ aCurrentNode hasRight ]
		whileTrue: [ aCurrentNode := aCurrentNode right ].
	^ aCurrentNode