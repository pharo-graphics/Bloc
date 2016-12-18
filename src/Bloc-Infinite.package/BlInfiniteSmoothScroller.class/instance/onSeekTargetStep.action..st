hooks
onSeekTargetStep: aDeltaPoint action: aScrollerAction
	"InfiniteElement will call me each time it scrolls until it can find the target position in the layout.
	SmoothScroller should check aDeltaPoint and if scroll should be changed,
	update the provided aScrollerAction to define the next scroll"

	self subclassResponsibility