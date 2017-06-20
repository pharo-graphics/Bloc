initialization
initializeResourcesOn: aHostRenderer
	"Initialize me and host renderer depending on surface type.
	must be implemented by subclasses"
	
	self initializeOn: aHostRenderer