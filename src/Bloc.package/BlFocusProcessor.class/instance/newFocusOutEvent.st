instance creation
newFocusOutEvent
	"Create, initialize and return a focus-out event that should be sent
	as a part of blur processing"
	<return: #BlFocusOutEvent>
	
	^ BlFocusOutEvent new
		canBePropagated: false;
		yourself