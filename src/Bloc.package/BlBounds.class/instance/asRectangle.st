converting
asRectangle
	"Convert me to immutable Rectangle.
	Note, that using left:right:top:bottom: is the fastest way to create
	a rectangle from set of numbers (faster than Point#>>corner:)"
	<return: #Rectangle>

	^ Rectangle left: left right: right top: top bottom: bottom