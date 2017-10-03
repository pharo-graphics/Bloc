notifying
notify: anElement
	"Send an event letting element's event handlers know that a property changed.
	Should be done once"
	| lastValue |
	
	self
		assert: [ self hasActiveChanges ]
		description: [ 'I must have active changes in order to notify them' ].

	lastValue := loggedValues last changedValue.
	
	(lastNotifiedValue = lastValue)
		ifFalse: [
			loggedValues last beNotified.
			self notifyChanges: anElement ].
	
	lastNotifiedValue := lastValue.
	hasActiveChanges := false