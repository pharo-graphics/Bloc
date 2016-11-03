converting
asDragEnterEvent
	"Convert the receiver into a mouse move"

	^ BlDragEnterEvent new
		copyFrom: self;
		yourself