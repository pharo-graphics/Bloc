children add/remove
removeAndRecycleChild: anElement
	"Remove a child element and recycle it using BlInfiniteRecycler."
	
	self removeChild: anElement.
	self recycler recycleElement: anElement