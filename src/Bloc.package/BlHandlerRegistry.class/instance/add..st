api - adding / removing
add: aHandler
	"Adds a given event handler to the registry.
	aHandler must not be nil and must not be already registered"
	
	self subclassResponsibility