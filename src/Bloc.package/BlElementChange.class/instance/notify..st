notifying
notify: anElement
	"Send an event letting element's event handlers know that a property changed.
	Should be done once"
	
	self
		assert: [ self hasActiveChanges ]
		description: [ 'I must have active changes in order to notify them' ].
		
	self notifyChanges: anElement.
	
	hasActiveChanges := false