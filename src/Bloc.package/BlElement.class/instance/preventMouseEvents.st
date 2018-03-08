event handling
preventMouseEvents
	"Prevent *me* from handling mouse events.
	It does not influence the ability of the children to handle events, hence I am a local property"
	
	shouldHandleMouseEvents := false