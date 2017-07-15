instance creation
newFocusInEvent
	"Create, initialize and return a focus-in event that should be sent
	as a part of focus processing"
	<return: #BlFocusInEvent>
	
	^ BlFocusInEvent new
		canBePropagated: false;
		yourself