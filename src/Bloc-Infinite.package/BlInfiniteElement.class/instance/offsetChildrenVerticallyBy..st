children - geometry
offsetChildrenVerticallyBy: aNumber
	self childrenDo: [ :anElement |
		anElement position: anElement position x @ (anElement position y + aNumber) ]