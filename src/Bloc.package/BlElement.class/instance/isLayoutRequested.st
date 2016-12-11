layout
isLayoutRequested
	"Indicates whether or not this elements's layout will be requested during the next hierarchy layout pass.
	Return true if the layout will be forced during next layout pass, false otherwise"
	<return: #Boolean>

	^ self layout requestingLayout