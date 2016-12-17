children - geometry
offsetChildrenVerticallyBy: aNumber
	
	childrenManager childrenDo: [ :anElement |
		anElement position: anElement position x @ (anElement position y + aNumber) ]