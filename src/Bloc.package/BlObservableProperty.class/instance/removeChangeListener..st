change management
removeChangeListener: aListener
	"Remove the argument from the list of listeners"

	self
		assert: [ (changeListeners includes: aListener) ]
		description: [ 'Listener must exist!' ].
	
	changeListeners := changeListeners copyWithout: aListener