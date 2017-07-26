children add/remove
removeChildren
	| oldChildren |
	"Remove all my direct children, request layout update and redraw."
	
	"fast exit if I have no children"
	self hasChildren
		ifFalse: [ ^ self ].
	
	"first update element's parent to nil"
	oldChildren := self children.

	oldChildren do: [ :anElement |
		"First of all, we have to damage area occupied by removed element"
		anElement invalidate.
		"then we request layout update while element is not yet removed"
		anElement requestLayout.

		anElement parent: nil ].

	"actually remove children"
	self resetChildrenArray.
	"send hook after elements has been removes"
	oldChildren do: [ :anElement | self dispatchChildRemoved: anElement ].
	"finally requesting children changed"
	self childrenChanged