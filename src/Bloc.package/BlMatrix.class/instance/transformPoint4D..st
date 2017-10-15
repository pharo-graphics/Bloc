matrix - transforming points
transformPoint4D: aPoint4D
	"Transform a given 4D point according to this transformation matrix"
	<return: #BlPoint4D>
	
	^ self subclassResponsibility