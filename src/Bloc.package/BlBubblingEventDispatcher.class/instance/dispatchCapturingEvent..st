dispatching
dispatchCapturingEvent: anEvent
	
	anEvent capturingTarget: self owner.
	
	"filters initialized lazily, do nothing if there are none of them"
	filters ifNotNil: [ :theFilters |
		theFilters dispatchEvent: anEvent ]