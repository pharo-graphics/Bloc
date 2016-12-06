children - add/remove
removeAndRecycleAllChildren
	"Remove all elements and recycle them using the infinite recycler.
	If you want to clean cached elements as well, you should sent #BlInfiniteRecycler>>#clear too"

	self reverseChildrenDo: [ :anElement :anIndex |
		(infiniteElement elementHolderOf: anElement) shouldIgnore
			ifFalse: [ self removeAndRecycleChildAt: anIndex ] ]