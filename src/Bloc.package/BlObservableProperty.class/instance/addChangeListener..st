change management
addChangeListener: aListener

	self
		assert: [ (changeListeners includes: aListener) not ]
		description: [ 'Listener must not be already added!' ].

	changeListeners := changeListeners copyWith: aListener