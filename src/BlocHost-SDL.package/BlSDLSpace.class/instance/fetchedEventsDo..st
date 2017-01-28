host space - events
fetchedEventsDo: aBlock
	| theEvents |

	theEvents := LinkedList new.
	eventQueue flush: [ :anEvent | theEvents add: anEvent ].
	theEvents do: aBlock