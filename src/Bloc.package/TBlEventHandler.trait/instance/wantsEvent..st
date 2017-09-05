events
wantsEvent: anEvent
	"Return true if I am interested in a given event and want to handle it,
	false otherwise"
	<return: #Boolean>

	^ self explicitRequirement