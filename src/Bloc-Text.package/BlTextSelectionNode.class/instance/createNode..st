instance creation
createNode: aSelection
	^ (self class selection: aSelection)
		parent: self;
		yourself