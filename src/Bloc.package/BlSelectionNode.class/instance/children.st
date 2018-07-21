accessing
children
	"Return a collection of children selection nodes"
	<return: #Array of: #BlSelectionNode>
	
	^ Array streamContents: [ :aStream |
		self hasLeft
			ifTrue: [ aStream nextPut: self left ].
		self hasRight
			ifTrue: [ aStream nextPut: self right ] ]