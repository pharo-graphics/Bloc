private - inserting
insertBinary: aRedBlackNode
	"Insert a Node using classic binary search tree algorithm marking a new added node as RED"

	"Mark it as red"
	aRedBlackNode beRed.

	aRedBlackNode key < self key
		ifTrue: [
			self hasLeft
				ifTrue: [ self left insertBinary: aRedBlackNode ]
				ifFalse: [ self left: aRedBlackNode ] ]
		ifFalse: [
			self hasRight
				ifTrue: [ self right insertBinary: aRedBlackNode ]
				ifFalse: [ self right: aRedBlackNode ] ]