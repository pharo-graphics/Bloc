testing
hasHandler: anEventHandler
	^ self anySatisfy: [ :each | each = anEventHandler ]