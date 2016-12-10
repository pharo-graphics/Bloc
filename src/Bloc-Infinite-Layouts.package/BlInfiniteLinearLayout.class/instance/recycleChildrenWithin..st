private - recycling
recycleChildrenWithin: anInterval
	"Recycle all children within given interval"
	| aNormalizedInterval |

	aNormalizedInterval := anInterval last > anInterval first
		ifTrue: [ anInterval ]
		ifFalse: [ anInterval inversed ].
	
	aNormalizedInterval reverseDo: [ :anIndex |
		self removeAndRecycleChildAt: anIndex ]