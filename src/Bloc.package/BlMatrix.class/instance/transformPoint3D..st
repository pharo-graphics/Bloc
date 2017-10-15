matrix - transforming points
transformPoint3D: aPoint3D
	"Transform a given 3D point according to this transformation matrix"
	<return: #BlPoint3D>
	
	^ self subclassResponsibility