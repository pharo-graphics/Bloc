children - add/remove
detachAndScrapChild: anElement
	"Detach a child element and add it to a BlInfiniteRecycler's scrap heap.
	Scrapping an element allows it to be rebound and reused to show updated or different data"
	| anIndex |
	
	anIndex := childManager childIndexOf: anElement.
	self scrapOrRecycleChild: anElement at: anIndex