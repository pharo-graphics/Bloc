children add/remove
removeAndRecycleChildAt: anIndex
	"Remove a child element at anIndex and recycle it using BlInfiniteRecycler."
	| anElement |

	anElement := self childAt: anIndex.
	self removeChildAt: anIndex.
	self recycler recycleElement: anElement