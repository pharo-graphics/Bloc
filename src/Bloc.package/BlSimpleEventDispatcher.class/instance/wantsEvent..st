testing
wantsEvent: anEvent
	"Return true if there are any filters or handlers interesting in a given event,
	false otherwise"
	<return: #Boolean>

	^ (self filters anySatisfy: [ :aFilter | aFilter wantsEvent: anEvent ])
		or: [ self handlers anySatisfy: [ :aHandler | aHandler wantsEvent: anEvent ] ]