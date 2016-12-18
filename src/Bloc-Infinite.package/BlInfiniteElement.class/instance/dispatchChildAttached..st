dispatching
dispatchChildAttached: anElement
	"I am used by
		- ChildrenController's addChild:at:"
	| anElementHolder |
	
	anElementHolder := self elementHolderOf: anElement.
	self onChildAttached: anElement.
	self dataSource onElementAttached: anElementHolder.
	self notifyChildAttached: anElement