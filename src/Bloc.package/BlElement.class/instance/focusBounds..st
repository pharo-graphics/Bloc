geometry bounds
focusBounds: aBlBounds
	"Store my focused area in the given bounds and return it. Focused area
	is used to search next focusable element. By default focused bounds property
	is just local bounds. Override me to return more specific area, for example
	cursor bounds or selected cell in the table"
	<return: #BlBounds>
	
	^ self boundsInLocal: aBlBounds