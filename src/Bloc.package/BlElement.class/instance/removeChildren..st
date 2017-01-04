children add/remove
removeChildren: aListOfElements
	"Remove all elements listed in aListOfElements from my direct children.
	All elements must be my direct children.
	@use BlElement>>#removeChildren if you want to remove all my children
	@see BlElement>>#removeChild: for more info
	aListOfElements must not be nil."
	self assert: aListOfElements isNotNil.
	self
		assert: [ aListOfElements allSatisfy: [ :anElement | anElement parent == self ] ]
		description: [ 'I can only remove my direct children!' ].
	
	aListOfElements do: [ :anElement |
		"First of all, we have to damage area occupied by removed element"
		anElement invalidate.
		"then we request layout update while element is not yet removed"
		anElement requestLayout.
		anElement parent: nil ].
	self children removeAll: aListOfElements.
	aListOfElements do: [ :anElement | self dispatchChildRemoved: anElement ].

	self managedChildrenChanged