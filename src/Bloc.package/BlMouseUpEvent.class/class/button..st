instance creation
button: aMouseButton
	"Create a sample button up event for a given button for testing purposes"
	<return: #BlMouseUpEvent>
	
	^ self new
		button: aMouseButton;
		position: 0@0;
		screenPosition: 0@0;
		timestamp: DateAndTime now