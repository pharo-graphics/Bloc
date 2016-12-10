children - add/remove
detachAndScrapAttachedChildren
	"Temporarily detach and scrap all currently attached child element.
	Elements will be scrapped into the InfiniteRecycler.
	The Recycler may prefer to reuse scrap elements before other elements that were previously recycled"
	
	self reverseChildrenDo: [ :anElement :anIndex |
		self scrapOrRecycleChild: anElement at: anIndex ]