converting
asPoint2D
	<return: #BlPoint2D>

	^ BlPoint2D x: (self x asFloat / self w) y: (self y asFloat / self w)