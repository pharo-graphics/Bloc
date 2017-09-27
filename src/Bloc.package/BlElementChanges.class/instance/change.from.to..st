changes
change: aChangeClass from: anOldValue to: aNewValue

	(changeMap
		at: aChangeClass
		ifAbsentPut: [ aChangeClass new oldValue: anOldValue ])
			newValue: aNewValue