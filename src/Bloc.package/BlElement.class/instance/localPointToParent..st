geometry position convertion
localPointToParent: aPoint
	^ self transform localPointToGlobal: aPoint 