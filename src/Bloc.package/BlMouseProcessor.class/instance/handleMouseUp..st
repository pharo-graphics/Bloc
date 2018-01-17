mouse up
handleMouseUp: aMouseUpEvent
	"DragEnd, Simple click and Dbl click"
	| aTargetElement |

	"we need to unregister a button"
	self pressedButtons remove: aMouseUpEvent button.

	aTargetElement := self processPicking: aMouseUpEvent.
	aMouseUpEvent target: aTargetElement.

	"depending on whether drag and drop is in process handle mouse up either
	as mouse up itself or as drag end event"
	self isDragging
		ifFalse: [ self processMouseUp: aMouseUpEvent ]
		ifTrue: [ self processDragEnd: aMouseUpEvent ]