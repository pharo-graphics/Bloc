changes
onWidthChanged: aNumber
	"Is sent when the width of a curve changed to a given number.
	Arrowhead should adapt its geometry to match new properties.
	Note: aNumber is never 0"
	
	self subclassResponsibility