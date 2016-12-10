private - recycling
recycleChildrenWithin: anInterval
	"Recycle all children within given interval"
	
	anInterval reverseDo: [ :anIndex |
		self removeAndRecycleChildAt: anIndex ]