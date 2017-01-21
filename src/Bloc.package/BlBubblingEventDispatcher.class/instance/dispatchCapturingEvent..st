dispatching
dispatchCapturingEvent: anEvent

	"filters initialized lazily, do nothing if there are none of them"
	filters ifNotNil: [ :theFilters |
		theFilters dispatchEvent: anEvent ].
	^ anEvent