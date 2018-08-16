dispatching
dispatchChildDetached: anElement
	"I am used by
		- ChildrenController's removeChildAt: and removeAllChildren
		- InfiniteElement's removeDetachedChild:animate:"
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	self onChildDetached: anElementHolder.
	self dataSource onElementDetached: anElementHolder.
	self notifyChildDetached: anElement