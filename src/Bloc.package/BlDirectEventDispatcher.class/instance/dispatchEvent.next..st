api - event managing
dispatchEvent: anEvent next: aBlEventDispatcherChain
	<return: #BlEvent>
	
	anEvent isConsumed
		ifTrue: [ ^ anEvent ].
	
	anEvent target == self owner
		ifTrue: [ anEvent arrivedTarget: self owner. ]
		ifFalse: [ anEvent forwardingTarget: self owner ].

	"filters initialized lazily, do nothing if there are none of them"
	filters ifNotNil: [ :theFilters |
		theFilters dispatchEvent: anEvent ].

	anEvent isConsumed
		ifTrue: [ ^ anEvent ].

	"handlers initialized lazily, do nothing if there are none of them"
	handlers ifNotNil: [ :theHandlers |
		theHandlers dispatchEvent: anEvent ].
	
	anEvent isConsumed
		ifTrue: [ ^ anEvent ].

	"shortcutHandler is special case, treat it differently"
	(shortcutHandler wantsEvent: anEvent)
		ifTrue: [ shortcutHandler handleEvent: anEvent ].
		
	^ anEvent