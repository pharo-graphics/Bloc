accessing
pointerIndex
	"Return the ordered index of a pointer. Assume user touches the display
	with two fingers, the first finger put on a display receives index '1'
	while the second finger index '2'. Index is different from an id in which id tends to be unique"
	<return: #Number>

	^ pointerIndex