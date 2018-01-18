instance creation
button: aMouseButton
	"Create a sample button move event"
	<return: #BlMouseMoveEvent>

	^ self new
		button: aMouseButton;
		position: 0@0;
		screenPosition: 0@0;
		timestamp: DateAndTime now