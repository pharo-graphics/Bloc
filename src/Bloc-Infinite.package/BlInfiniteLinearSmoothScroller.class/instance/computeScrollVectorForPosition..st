physics
computeScrollVectorForPosition: aPosition
	"Compute the scroll vector for a given target position.
	I can return null if the layout cannot calculate a scroll vector for the given position
	(e.g. it has no current scroll position)

	Note, that BlInfiniteLayout does not implement #computeScrollVectorForPosition: by default,
	that is why you can either subclass me or infinite layout"
	<return: #Point>

	(self layout respondsTo: #computeScrollVectorForPosition:)
		ifFalse: [ self shouldBeImplemented ].

	^ self layout computeScrollVectorForPosition: aPosition