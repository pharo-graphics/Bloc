dispatching
dispatchArrivedEvent: anEvent
	
	anEvent arrivedTarget: self owner.
	
	"handlers initialized lazily, do nothing if there are none of them"
	handlers ifNotNil: [ :theHandlers |
		theHandlers dispatchEvent: anEvent ].

	"shortcutHandler is special case, treat it differently but first check if
	event is consumed or not"
	(anEvent isConsumed not and: [ shortcutHandler wantsEvent: anEvent ])
		ifTrue: [ shortcutHandler handleEvent: anEvent ]