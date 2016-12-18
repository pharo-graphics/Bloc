hooks
onTargetFound: anElement action: aScrollingAction
	"Sent when the target position is laid out.
	I am the last message sent SmoothScroller will receive and it should update
	the provided aScrollingAction to define the scroll details towards the target element"
	
	self subclassResponsibility