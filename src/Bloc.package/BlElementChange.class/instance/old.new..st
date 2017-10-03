change logging
old: anOldValue new: aNewValue
	self
		assert: [ loggedValues isEmpty or: [ loggedValues last changedValue = anOldValue ] ]
		description: [ 'Last logged value must be equal to the old value that is being changed' ].
	self
		assert: [ anOldValue ~= aNewValue ]
		description: [ 'Old and new values must be different' ].
		
	loggedValues
		ifEmpty: [ loggedValues add: (self newChangeValue: anOldValue) ].
		
	loggedValues add: (self newChangeValue: aNewValue).
	hasActiveChanges := true