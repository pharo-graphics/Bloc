children accessing
childPositionOf: anElement
	"Returns the datasource position of the item represented by the given Element.
	This does not contain any datasource changes that might have happened after the last layout"
	<return: #Number>

	^ anElement constraints infinite elementLayoutPosition