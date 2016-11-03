children add/remove
removeChild: anElement
	"Request layout and redraw an area occupied by anElement.
	As result anElement sends BlElementRemovedEvent
	anElement must not be nil.
	anElement must be my direct child"
	self assert: anElement isNotNil.
	self assert: anElement parent = self.

	anElement parent: nil.
	self children remove: anElement.
	"send hook to the element that it was removed"
	anElement notifyRemovedFromParent.
	self managedChildrenChanged 