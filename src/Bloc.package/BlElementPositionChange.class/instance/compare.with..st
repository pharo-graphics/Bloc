comparing
compare: aNewValue with: anOldValue
	"Return true if new value is equal (or close to) to new value"
	<return: #Boolean>

	^ aNewValue closeTo: anOldValue