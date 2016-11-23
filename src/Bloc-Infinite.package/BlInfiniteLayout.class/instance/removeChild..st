children - add/remove
removeChild: anElement
	"Remove an element from the currently attached infinite element if needed.
	InfiniteLayouts should use this method to completely remove a child view that is no longer needed.
   Note: InfiniteLayouts should strongly consider recycling removed views using BlInfiniteRecycler#recycleElement:"

	childManager removeChild: anElement