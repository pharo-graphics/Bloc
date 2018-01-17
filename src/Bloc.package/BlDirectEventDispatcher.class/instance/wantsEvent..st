api - event managing
wantsEvent: anEvent
	"Return true if there are any filters or handlers interesting in a given event,
	false otherwise"
	<return: #Boolean>

	"first ask shortcutHandler because it always presents"
	(shortcutHandler wantsEvent: filters)
		ifTrue: [ ^ true ].

	(filters isNotNil and: [ filters anySatisfy: [ :aFilter | aFilter wantsEvent: anEvent ] ])
		ifTrue: [ ^ true ].

	(handlers isNotNil and: [ handlers anySatisfy: [ :aHandler | aHandler wantsEvent: anEvent ] ])
		ifTrue: [ ^ true ].

	^ false