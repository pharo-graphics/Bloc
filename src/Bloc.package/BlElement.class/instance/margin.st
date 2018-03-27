api - layout
margin
	"Return my current margin - a space outside around my bounds.
	Layouts that support margin may want to expand children such that there is a space gap around them"
	<return: #BlInsets>

	^ self constraints margin