children hooks
onRemovedFromParent: aParentElement
	super onRemovedFromParent: aParentElement.
	
	aParentElement removeEventHandler: borderListener