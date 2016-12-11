event management testing
hasEventHandlers
	"Returns true if one or more event handlers are attached to this data source"
	<return: #Boolean>

	^ self eventDispatcher handlers handlers isNotEmpty