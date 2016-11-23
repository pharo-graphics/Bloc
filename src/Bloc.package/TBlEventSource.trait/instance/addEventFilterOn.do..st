event management
addEventFilterOn: anEventClass do: aBlock
	self addEventFilter: (BlEventHandler on: anEventClass do: aBlock)