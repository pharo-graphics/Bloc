geometry hooks
notifyExtentChanged
	"Notify element event listeners that my extent changed.
	Custom event handlers should subscribe to BlElementExtentChangedEvent"
	
	self dispatchEvent: (BlElementExtentChangedEvent target: self)