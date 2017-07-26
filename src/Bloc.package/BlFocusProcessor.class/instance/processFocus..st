focus - processing
processFocus: anElement	
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not give focus to nil' ].
	self
		assert: [ anElement ~= focusOwner ]
		description: [ 'Can not give focus to the already focused element' ].

	"first make element to be focused"
	focusOwner := anElement.
	self space focusOwner: anElement.
	anElement focused: true.

	"then send events"
	self fireFocusInEvent: anElement.
	self fireFocusEvent: anElement