private - recycling
recycleChildren
	"Recycle children depending on current layout direction"
	
	(layoutState allowRecycling not or: [
		layoutState isInfinite ])
			ifTrue: [ ^ self ].
			
	layoutState isLayoutStartDirection
		ifTrue: [ self recycleChildrenFromEnd: layoutState scrollingOffset ]
		ifFalse: [ self recycleChildrenFromStart: layoutState scrollingOffset ]