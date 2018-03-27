api - layout
padding
	"Return my current padding - a space inside of me around my content.
	Layouts that support padding may want to offset children such that they are within my bounds inset by padding"
	<return: #BlInsets>

	^ self constraints padding