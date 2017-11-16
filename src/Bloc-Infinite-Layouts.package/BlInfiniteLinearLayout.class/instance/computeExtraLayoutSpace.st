layout - geometry
computeExtraLayoutSpace
	"Return the amount of extra space that should be laid out by InfiniteLayout.
	By default, I lay out 1 extra page of items while smooth scrolling and 0 otherwise.
	You can override this method to implement your custom layout pre-cache logic.
	Laying out invisible elements will eventually come with performance cost. On the other
	hand, in places like smooth scrolling to an unknown location, this extra content helps
	InfiniteLayout to calculate a much smoother scrolling; which improves user experience.
	You can also use this if you are trying to pre-layout your upcoming elements"
	<return: #Number>

	self state hasTargetScrollPosition
		ifTrue: [ ^ self orientation totalSpace ].

	^ 0