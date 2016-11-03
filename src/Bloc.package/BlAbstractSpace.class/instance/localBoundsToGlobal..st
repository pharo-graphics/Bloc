geometry bounds
localBoundsToGlobal: aRectangle
	^ Rectangle
		encompassing: (aRectangle corners collect: [ :pt | self hostWindow view localPointToGlobal: pt ])