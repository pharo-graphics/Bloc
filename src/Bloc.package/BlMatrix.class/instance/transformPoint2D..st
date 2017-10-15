matrix - transforming points
transformPoint2D: aPoint2D
	"Transform a given 2D point (either a ==Point== or ==BlPoint2D==).
	In any case return BlPoint2D"
	<return: #BlPoint2D>

	^ self subclassResponsibility