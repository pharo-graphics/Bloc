initialization
initialize
	super initialize.
	
	children := OrderedCollection new.
	startBreadth := 0.
	startLength := 0.
	length := 0.
	breadth := 0.
	
	"initialized by layoutSpec:"
	measurer := nil