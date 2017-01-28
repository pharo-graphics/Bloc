host space - events
fetchedEventsDo: aBlock
	| events |
	events := LinkedList new.
	eventQueue flush: [ :event | events add: event ].
	events do: aBlock