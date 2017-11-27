notifying
commitOn: anElement
	"Commit changes done to the given element if there are any"
	| lastValue |

	self hasActiveChanges
		ifFalse: [ ^ self ].

	lastValue := records last changedValue.

	(previousValue isNil or: [ (self compare: lastValue with: previousValue) not ])
		ifTrue: [
			records last beNotified.
			self commitChange: lastValue on: anElement ].

	previousValue := lastValue.
	hasActiveChanges := false