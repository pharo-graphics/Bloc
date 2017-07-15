focus - processing
processBlur: anElement
	self
		assert: [ self hasFocusOwner ]
		description: [ 'Blur event can only be processed when there is a focused element' ].

	"First make a given element to loose focus, then send events"
	anElement focused: false.

	self fireFocusOutEvent: anElement.
	self fireBlurEvent: anElement