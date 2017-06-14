event processing
fetchedEventsDo: aBlock
	"Flush event queue and evaluate a given block with every queued event as argument"
	| theEvents |

	theEvents := LinkedList new.
	eventQueue flush: [ :anEvent | theEvents add: anEvent ].
	theEvents do: aBlock