children add/remove
removeChildNamed: aContainerName
	self
		childNamed: aContainerName
		ifFound: [ :aContainerElement | aContainerElement removeFromParent ]
		ifNone: [ "do nothing, no need to raise an exception" ]