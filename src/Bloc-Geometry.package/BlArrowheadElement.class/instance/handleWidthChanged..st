changes
handleWidthChanged: aWidth
	"Is sent when the width of a curve changed to a given number.
	Arrowhead should adapt its geometry to match new properties"
	
	aWidth isZero
		ifTrue: [ self beForZeroWidth ]
		ifFalse: [ self onWidthChanged: aWidth ]