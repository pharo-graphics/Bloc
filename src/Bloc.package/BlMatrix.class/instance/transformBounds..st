matrix - transforming points
transformBounds: aBlBounds
	"In-place transform given BlBounds according to my transformation.
	(local to global transformation)"
	<return: #BlBounds>
	
	^ self subclassResponsibility