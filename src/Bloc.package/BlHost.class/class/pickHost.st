driver selection
pickHost
	"Find and instantiate a first supported host.
	Return a special null one if there are no available hosts"
	<return: #BlHost>
	
	"If setting is not set dispatches to back to me returning #defaultHostClass"
	^ Bloc preferableHostClass new