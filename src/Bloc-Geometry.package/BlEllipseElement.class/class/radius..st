instance creation
radius: aNumber
	"Create a circle element of a given radius"
	<return: #BlEllipseElement>
	
	^ self new
		majorRadius: aNumber;
		minorRadius: aNumber