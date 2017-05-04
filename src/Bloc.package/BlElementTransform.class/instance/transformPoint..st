transformation
transformPoint: aPoint
	"Transform given 2D point according to my transformation and return a transformed result point.
	(local to global transformation)"

	<return: #Point>
	self ensure2D.
	^ matrix2D transformPoint: aPoint