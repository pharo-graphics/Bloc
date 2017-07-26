focus - requesting
requestFor: anElement
	self
		assert: [ anElement isNotNil ]
		description: [ 'Focus requester must not be nil!' ].

	focusOwner = anElement
		ifTrue: [ ^ self ].

	"we should only process blur event when there is focused element, otherwise skip it"
	self hasFocusOwner
		ifTrue: [ self processBlur: focusOwner ].

	"don't forget to forget focused element"
	focusOwner := nil.
	"focus is processed with new requested focus owner"
	self processFocus: anElement