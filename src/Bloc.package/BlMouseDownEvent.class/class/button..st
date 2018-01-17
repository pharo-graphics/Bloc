instance creation
button: aMouseButton
	"Create a sample button down event for a given button for testing purposes"
	<return: #BlMouseDownEvent>

	^ self new
		button: aMouseButton;
		position: 0@0;
		screenPosition: 0@0;
		timestamp: DateAndTime now