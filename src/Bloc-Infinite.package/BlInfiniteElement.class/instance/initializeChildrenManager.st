initialization
initializeChildrenManager
	childrenManager := self defaultChildrenManager.
	self defaultChildrenController
		infiniteElement: self;
		childrenManager: childrenManager