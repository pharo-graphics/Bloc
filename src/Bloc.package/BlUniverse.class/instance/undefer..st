deferred actions
undefer: aValuable
	"I remove previously deferred valuable from deferred actions queue if any
	and return true if aValuable existed, false otherwise.
	Note: Since I delete an action I do not request next pulse!"
	<return: #Boolean>
	| foundAny |
	
	foundAny := false.
	deferredActions flushAllSuchThat: [ :anAction | foundAny := foundAny or: [ anAction == aValuable ] ].
	^ foundAny