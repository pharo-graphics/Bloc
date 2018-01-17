testing
isLayoutRequested
	"Indicates whether or not root (or glass) element's layout needs to be updated next frame"
	<return: #Boolean>
	
	^ self root isLayoutRequested
		or: [ self glass isLayoutRequested ]