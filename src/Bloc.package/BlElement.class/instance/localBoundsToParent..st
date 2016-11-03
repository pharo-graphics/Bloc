geometry bounds convertion
localBoundsToParent: aRectangle
	| r |
	r := self transform localBoundsToGlobal: aRectangle.
	^ (r translateBy: self position) 