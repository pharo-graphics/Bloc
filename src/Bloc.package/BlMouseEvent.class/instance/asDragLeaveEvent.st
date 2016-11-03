converting
asDragLeaveEvent
	"Convert the receiver into a mouse move"

	^ BlDragLeaveEvent new
		copyFrom: self;
		yourself