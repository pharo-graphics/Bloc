api - touch up
handleTouchUp: aTouchEvent
	| aTargetElement aPointerIndex |

	"we need to unregister a pointer"
	
	aPointerIndex := self pressedPointers indexOf: aTouchEvent pointerId.
	self pressedPointers removeAt: aPointerIndex.
	
	aTargetElement := self processPicking: aTouchEvent.
	
	aTouchEvent target: aTargetElement.
	aTouchEvent pointerIndex: aPointerIndex.

	self processTouchUp: aTouchEvent