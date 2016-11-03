event processing
fetchedEventsDo: aBlock
	| events |
	events := LinkedList new.
	self eventQueue flush: [ :event | events add: event ].
	events do: aBlock