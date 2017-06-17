arithmetic
max
	"Return the biggest corner radius among top left, top right, bottom left and bottom right"
	<return: #Number>

	^ topLeft max: (topRight max: (bottomLeft max: bottomRight))