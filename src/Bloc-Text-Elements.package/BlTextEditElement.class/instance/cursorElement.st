cursor - management
cursorElement
	"Return an element representing a cursor"
	<return: #BlTextCursorElement>
	
	self
		assert: [ self cursorExists ]
		description: [ 'Can not access cursor if it does not exist' ].

	^ cursorElement