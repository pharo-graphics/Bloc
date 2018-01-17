api - adding / removing
remove: aHandler
	"Remove given event handler from my registry.
	Provided handler must not be nil and must be registered"
	
	self subclassResponsibility