children add/remove
removeChildren: aListOfElements
	"Remove all elements listed in aListOfElements from my direct children.
	All elements must be my direct children.
	@use BlElement>>#removeChildren if you want to remove all my children
	@see BlElement>>#removeChild: for more info
	aListOfElements must not be nil."
	self assert: aListOfElements isNotNil.
	
	aListOfElements do: [ :aNode | aNode parent: nil ].
	self children removeAll: aListOfElements.
	aListOfElements do: #notifyRemovedFromParent.
	self managedChildrenChanged