children - add/remove
detachAndScrapChildAt: anIndex
	"Detach a child element at anIndex and add it to a BlInfiniteRecycler's scrap heap.
	Scrapping a view allows it to be rebound and reused to show updated or different data"
	| anElement |
	
	anElement := self childAt: anIndex.
	self scrapOrRecycleChild: anElement at: anIndex