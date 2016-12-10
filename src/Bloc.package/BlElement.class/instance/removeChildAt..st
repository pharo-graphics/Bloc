children add/remove
removeChildAt: anIndex
	"Remove my direct child at a specified index.
	Request layout and redraw an area occupied by anElement.
	As result anElement sends BlElementRemovedEvent
	anIndex must be within children array bounds"
	| anElement |
	self
		assert: [ anIndex between: 1 and: self children size ]
		description: [ 'anIndex must be within children array bounds' ].
	
	anElement := self children at: anIndex.
	anElement parent: nil.
	self children removeAt: anIndex.
	anElement notifyRemovedFromParent.
	self managedChildrenChanged.