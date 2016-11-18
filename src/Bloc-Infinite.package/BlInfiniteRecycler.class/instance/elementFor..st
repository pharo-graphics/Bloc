accessing - element
elementFor: aPosition
	"Returns an element representing the data at a position from data source.
	I should be used by InfiniteLayout implementations to obtain elements to represent data from a DataSource.

	Recycler may reuse a scrap or detached element from a shared pool if one is
	available for the correct element type. If the data source has not indicated that the
	data at the given position has changed, the Recycler will attempt to hand back
	a scrap element that was previously initialized for that data without rebinding."
	<return: #BlElement>

	^ self elementFor: aPosition dryRun: false