children - add/remove
removeChildAt: anIndex
	"Remove an element at the index from the currently attached infinite element if needed.
	InfiniteLayouts should use this method to completely remove a child view that is no longer needed.
   Note: InfiniteLayouts should strongly consider recycling removed views using BlInfiniteRecycler#recycleElement:"

	(self childAt: anIndex)
		ifNotNil: [ childManager removeChildAt: anIndex ]