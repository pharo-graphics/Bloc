as yet unclassified
outside: aClient on: anEventClass do: aBlock
	^ (self
		on: anEventClass
		do: aBlock)
		client: aClient;
		yourself