notifying
notify: anElement
	"Notify element event listeners that position within parent has been changed.
	Custom event handlers should subscribe to BlElementPositionChangedEvent"
	
	anElement dispatchEvent: (BlElementPositionChangedEvent target: anElement)