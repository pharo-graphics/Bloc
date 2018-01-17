api - testing
hasHandler: anEventHandler
	"Return true if a given event handler is registered, false otherwise"
	<return: #Boolean>

	^ self anySatisfy: [ :each | each = anEventHandler ]