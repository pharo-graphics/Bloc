recording
old: anOldValue new: aNewValue
	self
		assert: [ records isEmpty or: [ records last changedValue = anOldValue ] ]
		description: [ 'Last recorded value must be equal to the old value that is being changed' ].
	self
		assert: [ anOldValue ~= aNewValue ]
		description: [ 'Old and new values must be different' ].

	self records
		ifEmpty: [ self records add: (self newChangeValue: anOldValue) ].

	self records add: (self newChangeValue: aNewValue).
	hasActiveChanges := true