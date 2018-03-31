children - add/remove
removeAndRecycleAllChildrenIn: aBlInfiniteRecycler
	"Remove all elements and recycle them using the given infinite recycler.
	If you want to clean cached elements as well, you should sent #BlInfiniteRecycler>>#clear too.
	If an element is marked as 'ignored', it is not removed nor recycled."

	self reverseChildrenDo: [ :anElement :anIndex |
		(infiniteElement elementHolderOf: anElement) shouldIgnore
			ifFalse: [ self removeAndRecycleChildAt: anIndex ] ]