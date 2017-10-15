transformations
translateBy: aDelta 
	"Answer a 2D Point translated by delta (an instance of Point)."
	<return: #BlPoint2D>

	^ self class x: (aDelta x + x) y: (aDelta y + y)