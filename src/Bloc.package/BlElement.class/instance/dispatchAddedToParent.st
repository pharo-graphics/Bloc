children dispatching
dispatchAddedToParent
	"Sent after I was added to another element as direct child.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self dispatchEvent: (BlElementAddedToParentEvent target: self).
	self onAddedToParent