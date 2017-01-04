children add/remove
removeChild: anElement
	"Request layout and redraw an area occupied by anElement.
	As result anElement sends BlElementRemovedEvent
	anElement must not be nil.
	anElement must be my direct child"
	self assert: anElement isNotNil.
	self assert: anElement parent == self.
	
	"First of all, we have to damage area occupied by removed element"
	anElement invalidate.
	"then we request layout update while element is not yet removed"
	anElement requestLayout.

	anElement parent: nil.
	self children remove: anElement.
	self dispatchChildRemoved: anElement.
	
	"child removed"
	self managedChildrenChanged