notifying
commitChange: anNewValue on: anElement
	"Notify element event listeners that position within parent has been changed.
	Custom event handlers should subscribe to BlElementPositionChangedEvent"
	
	anElement onPositionChanged.
	anElement onPositionInSpaceChanged.

	self notifyPositionInSpaceChanged: anElement