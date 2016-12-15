pulse
doUpdateFocus
	self focusOwner isNil ifTrue: [ 
		^ self initializeFocus ].
	self focusOwner space ~= self ifTrue: [ 
		self focusOwner: nil.
		^ self initializeFocus ]