controller
editListener
	"Return my current edit listener.
	Note: I never return nil, so users should first check #hasEditListener before
	asking for it, otherwise behaviour is undefined"
	<return: #BlTextEditListener>
	self
		assert: [ editListener isNotNil ]
		description: [ 'Edit listener can not be nil' ].

	^ editListener