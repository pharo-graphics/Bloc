arithmetic
min
	"Return the smallest corner radius among top left, top right, bottom left and bottom right"
	<return: #Number>
	
	^ topLeft min: (topRight min: (bottomLeft min: bottomRight))