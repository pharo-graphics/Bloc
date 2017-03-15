geometry hooks
notifyPositionInSpaceChanged
	"Notify element event listeners that my position in space coordinates changed.
	Custom event handlers should subscribe to BlElementPositionInSpaceChangedEvent"
	
	self dispatchEvent: (BlElementPositionInSpaceChangedEvent target: self)