event handling
preferableEventHandlerRegistry
	<return: #'BlHandlerRegistry class'>

	^ PreferableEventHandlerRegistry ifNil: [ self defaultEventHandlerRegistry ]