notifying
notify: anElement
	"Notify element event listeners that element's extent changed.
	Custom event handlers should subscribe to BlElementExtentChangedEvent"

	anElement dispatchEvent: (BlElementExtentChangedEvent target: anElement)