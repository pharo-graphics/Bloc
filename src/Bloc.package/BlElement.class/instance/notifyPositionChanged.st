geometry hooks
notifyPositionChanged
	"Notify element event listeners that my position within a parent changed.
	Custom event handlers should subscribe to BlElementPositionChangedEvent"
	
	self dispatchEvent: (BlElementPositionChangedEvent target: self)