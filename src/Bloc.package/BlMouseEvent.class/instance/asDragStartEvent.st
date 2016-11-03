converting
asDragStartEvent
	"Convert the receiver into a mouse move"

	^ BlDragStartEvent new
		copyFrom: self;
		yourself