pulse
doUpdateFocus
	self focusOwner
		ifNil: [ self initializeFocus ]
		ifNotNil: [ :anElement |
			anElement space == self
				ifFalse: [
					self focusOwner: nil.
					self initializeFocus ] ]