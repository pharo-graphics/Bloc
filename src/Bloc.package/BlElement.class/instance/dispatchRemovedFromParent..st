children dispatching
dispatchRemovedFromParent: aParentElement
	"Sent after I was removed from my parent and is not longer its direct child.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self dispatchEvent: (BlElementRemovedEvent target: self).
	self onRemovedFromParent: aParentElement